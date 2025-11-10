"""Google AI Studio (Gemini) client utilities for generating SQL solutions.

Responsibilities:
1. Initialize Gemini model using API key from environment (.env via python-dotenv)
2. Provide a function `generate_sql_solution(problem_html:str, problem_id:str, taxonomy_hint:str)`
   that returns a structured dict with fields: {sql, reasoning, taxonomy_section}
3. Apply repository conventions: header comments, dialect default (SQL Server), fallback notes.

Usage:
    from ai_client import generate_sql_solution
    sql_data = generate_sql_solution(html_text, "SQL1651", "aggregation_grouped")
    print(sql_data["sql"])

Security:
    The API key must be set as GOOGLE_API_KEY in environment; do not hardcode keys.
"""
from __future__ import annotations
import base64
import os
from typing import Dict, List, Tuple, Any
from pathlib import Path
import re
import json
import mimetypes
from urllib.parse import urlparse
from urllib.request import Request, urlopen
from urllib.error import URLError, HTTPError

try:
    from dotenv import load_dotenv
except ImportError:  # lightweight fallback if dotenv missing
    load_dotenv = lambda : None

load_dotenv()  # Load .env if present

GOOGLE_API_KEY = os.getenv("GOOGLE_API_KEY")
if not GOOGLE_API_KEY:
    raise RuntimeError("GOOGLE_API_KEY not set. Create .env from .env.example and set your key.")

try:
    import google.generativeai as genai
except ImportError as e:
    raise RuntimeError("google-generativeai not installed. Run: pip install -r requirements.txt") from e

genai.configure(api_key=GOOGLE_API_KEY)

_MODEL_NAME = "gemini-2.5-flash"  # cost-effective, fast; upgrade to pro if needed

_MAX_IMAGE_PARTS = 4
_MAX_IMAGE_BYTES = 5 * 1024 * 1024  # guardrail against huge payloads
_IMG_SRC_PATTERN = re.compile(r"<img[^>]+src\s*=\s*[\"']([^\"']+)[\"']", re.IGNORECASE)

_EVAL_PATH = Path(__file__).resolve().parent / "docs" / "evaluation.md"
try:
    _EVALUATION_GUIDE = _EVAL_PATH.read_text(encoding="utf-8")
except FileNotFoundError:
    _EVALUATION_GUIDE = ""

_SYSTEM_PROMPT = """You are an expert SQL assistant. Given an HTML problem definition extracted from PTIT, PRIORITIZE reading and decoding any images referenced by <img> tags, especially when they point to external URLs (http/https). Treat externally linked images as high-priority sources of schema, sample output, or column labels and attempt to fetch/interpret them using available vision/text capabilities before relying on surrounding HTML text. If an external image cannot be retrieved, explicitly mention that limitation in the reasoning and proceed using the nearest available schema/sample output in the HTML.

Produce ONLY the final SQL solution meeting these constraints:
1. IMPORTANT: Before writing the query, scan the HTML for any <img> tag. Prioritize external image links (http/https) and use Gemini's native vision/text capabilities to interpret those images and incorporate the decoded text exactly. Capture column labels and ordering from screenshots just as you would from regular HTML.
2. Also look for a field labelled 'Loại Database' or 'Database Type'; if present, switch to that dialect (e.g., MySQL, SQL Server) and note the choice in the header comment.
3. Match exactly the sample output columns (names, order, case) and include ORDER BY when sample ordering is implied.
4. Prefer JOINs over subqueries when clarity improves readability; always terminate statements with a semicolon. Use 1/0 (or 'Y'/'N') instead of TRUE/FALSE when working with BIT columns.
5. Provide header comments in the SQL: first line '-- Tables: <comma-separated tables>' and second line '-- Technique: <primary technique>'. Leave one blank line before SELECT. If a non-default dialect is used, append '(dialect: <name>)' to the Technique line.
6. taxonomy_section MUST be one of the 11 categories, in this exact taxonomy order. Follow the evaluation guide (attached below) when deciding:
    - modification — data/structure changes (`INSERT`, `UPDATE`, `DELETE`, `CREATE`, `ALTER`, `DROP`).
    - aggregation_simple — single aggregate metric without `GROUP BY`.
    - aggregation_grouped — aggregated metrics with `GROUP BY` (and optional `HAVING`).
    - window_functions — any analytic/window function using `OVER(...)` (ranking, running totals, gaps).
    - pivoting — row-to-column reshaping via conditional aggregation or `PIVOT`.
    - set_operations — `UNION`, `INTERSECT`, or `EXCEPT` as primary logic.
    - relational_division — "for all" requirements (e.g., bought *all* items) using `NOT EXISTS` or matching `COUNT` tricks.
    - range_join — join on non-equality conditions (`BETWEEN`, `<`, `>`).
    - filtering — main difficulty in `WHERE` clause (dates, text normalization, complex predicates).
    - retrieval — straightforward `SELECT`/`JOIN` lookups with equality conditions (default when none above apply).
    - complex — blends of 2+ advanced techniques or deeply nested logic beyond other categories.
7. Do NOT invent columns—derive everything from the schema or sample output (including decoded image text). If an image provides conflicting column names/order vs HTML, prefer the image-derived labels but document the choice in reasoning.
8. For problems that are *not* `modification`, provide ONLY the SELECT statement. For `modification` tasks, provide ONLY the required DML/DDL statement(s).
9. Output MUST be a single-line, minified JSON object with exactly these keys: sql, reasoning, taxonomy_section.
- sql value MUST be a fenced code block in the form ```sql\n...\n``` using neat indentation and blank lines for readability.
- Do not include backticks or text outside the JSON object.
- DO NOT PERFORM ANY DML/ DDL operations, ANY SQL SYSTEM MODIFICATIONS unless the problem tells to do so.
"""

def _guess_mime_from_url(url: str) -> str:
    parsed = urlparse(url)
    mime, _ = mimetypes.guess_type(parsed.path)
    return mime or "image/png"


def _decode_data_uri(uri: str) -> Tuple[genai_types.Blob | None, str | None]:
    match = re.match(r"data:([^;,]+)(?:;charset=[^;,]+)?;base64,(.*)", uri, re.IGNORECASE | re.DOTALL)
    if not match:
        return None, "Unsupported data URI format"
    mime = match.group(1)
    payload = re.sub(r"\s+", "", match.group(2))
    try:
        data = base64.b64decode(payload, validate=True)
    except Exception as exc:
        return None, f"Base64 decode failed: {exc}"
    if len(data) > _MAX_IMAGE_BYTES:
        return None, "Data URI exceeds image size limit"
    return genai_types.Blob(mime_type=mime or "image/png", data=data), None


def _fetch_remote_image(url: str) -> Tuple[genai_types.Blob | None, str | None]:
    req = Request(url, headers={"User-Agent": "Mozilla/5.0"})
    try:
        with urlopen(req, timeout=10) as resp:
            data = resp.read()
            if len(data) > _MAX_IMAGE_BYTES:
                return None, "Remote image exceeds size limit"
            mime = resp.info().get_content_type() or _guess_mime_from_url(url)
            return genai_types.Blob(mime_type=mime, data=data), None
    except (HTTPError, URLError, TimeoutError) as exc:
        return None, f"Fetch failed: {exc}"
    except Exception as exc:
        return None, f"Unexpected fetch error: {exc}"


def _collect_image_blobs(problem_html: str) -> Tuple[List[genai_types.Blob], List[str]]:
    blobs: List[genai_types.Blob] = []
    notes: List[str] = []
    seen = set()
    for src in _IMG_SRC_PATTERN.findall(problem_html):
        if src in seen:
            continue
        seen.add(src)
        if len(blobs) >= _MAX_IMAGE_PARTS:
            notes.append(f"Skipped image {src} due to attachment limit {_MAX_IMAGE_PARTS}.")
            continue
        if src.startswith("data:"):
            blob, err = _decode_data_uri(src)
        elif src.lower().startswith(("http://", "https://")):
            blob, err = _fetch_remote_image(src)
        else:
            notes.append(f"Unsupported image source {src}; skipping.")
            continue
        if blob:
            blobs.append(blob)
        elif err:
            notes.append(f"Failed to attach {src}: {err}")
    return blobs, notes


def _build_prompt(problem_html: str, problem_id: str, taxonomy_hint: str | None, image_notes: List[str] | None = None) -> str:
    parts = [
        f"<ID>{problem_id}</ID>\n",
        f"<TAXONOMY_HINT>{taxonomy_hint or 'unknown'}</TAXONOMY_HINT>\n",
    ]
    if _EVALUATION_GUIDE:
        parts.append("<EVALUATION_GUIDE>\n")
        parts.append(_EVALUATION_GUIDE)
        parts.append("\n</EVALUATION_GUIDE>\n")
    parts.append("<PROBLEM_HTML>\n")
    parts.append(problem_html)
    parts.append("\n</PROBLEM_HTML>\n")
    if image_notes:
        parts.append("<IMAGE_FETCH_NOTES>\n")
        for note in image_notes:
            parts.append(f"- {note}\n")
        parts.append("</IMAGE_FETCH_NOTES>\n")
    parts.append("Produce output JSON now.")
    return "".join(parts)

def generate_sql_solution(problem_html: str, problem_id: str, taxonomy_hint: str | None = None) -> Dict[str, str]:
    """Generate a SQL solution using Gemini.

    Parameters
    ----------
    problem_html : str
        Raw HTML content of the problem (already scraped).
    problem_id : str
        Problem code like 'SQL1651'.
    taxonomy_hint : str | None
    Optional hint for classification (e.g., 'aggregation_grouped'); model may override.

    Returns
    -------
    Dict[str,str]
        { 'sql': str, 'reasoning': str, 'taxonomy_section': str }
    """
    image_blobs, image_notes = _collect_image_blobs(problem_html)
    prompt = _build_prompt(problem_html, problem_id, taxonomy_hint, image_notes if image_notes else None)
    model = genai.GenerativeModel(_MODEL_NAME, system_instruction=_SYSTEM_PROMPT)
    payload = [prompt]
    if image_blobs:
        payload.extend(image_blobs)
    response = model.generate_content(payload)
    text = response.text.strip()

    def _parse_json_payload(t: str):
        # 1) code-fenced JSON
        m = re.search(r"```(?:json)?\s*(\{[\s\S]*?\})\s*```", t, re.IGNORECASE)
        candidate = m.group(1) if m else None
        # 2) raw JSON body
        if not candidate and t.startswith("{") and t.endswith("}"):
            candidate = t
        # 3) fallback: first brace block
        if not candidate:
            m2 = re.search(r"(\{[\s\S]*\})", t)
            candidate = m2.group(1) if m2 else None
        if not candidate:
            return None
        try:
            data = json.loads(candidate)
            return data
        except Exception:
            return None

    data = _parse_json_payload(text)
    if data and all(k in data for k in ("sql", "reasoning", "taxonomy_section")):
        return data
    # Fallback to raw text as SQL content
    return {"sql": text, "reasoning": "Non-JSON response; inspect manually.", "taxonomy_section": taxonomy_hint or "unknown"}

__all__ = ["generate_sql_solution"]
