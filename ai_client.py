"""Google AI Studio (Gemini) client utilities for generating SQL solutions.

Responsibilities:
1. Initialize Gemini models using API keys from environment (.env via python-dotenv).
2. Provide a function `generate_sql_solution(problem_html, problem_id, taxonomy_hint)`
   that returns a structured dict with fields: {sql, reasoning, taxonomy_section}.
3. Provide a function `classify_taxonomy(sql_payload, problem_id, taxonomy_hint)`
    that infers the taxonomy section directly from the generated SQL (plus optional reasoning).
4. Apply repository conventions: header comments, dialect default (SQL Server), fallback notes.

Usage:
    from ai_client import generate_sql_solution
    sql_data = generate_sql_solution(html_text, "SQL1651", "aggregation")
    print(sql_data["sql"])

Security:
    API keys must be sourced from environment variables; do not hardcode keys.
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
from functools import lru_cache

try:
    from dotenv import load_dotenv
except ImportError:  # lightweight fallback if dotenv missing
    load_dotenv = lambda : None

load_dotenv()  # Load .env if present

try:
    import google.generativeai as genai
except ImportError as e:
    raise RuntimeError("google-generativeai not installed. Run: pip install -r requirements.txt") from e

_SQL_API_KEY = os.getenv("GOOGLE_SQL_API_KEY") or os.getenv("GOOGLE_API_KEY")
if not _SQL_API_KEY:
    raise RuntimeError("GOOGLE_SQL_API_KEY (or legacy GOOGLE_API_KEY) not set. Configure your SQL model key in .env.")

_TAXONOMY_API_KEY = os.getenv("GOOGLE_TAXONOMY_API_KEY") or _SQL_API_KEY

_SQL_MODEL_NAME = os.getenv("GOOGLE_SQL_MODEL", "gemini-2.5-flash-lite")
_TAXONOMY_MODEL_NAME = os.getenv("GOOGLE_TAXONOMY_MODEL", _SQL_MODEL_NAME)

_TAXONOMY_OPTIONS = (
    "modification",
    "aggregation",
    "grouping_having",
    "pivoting",
    "set_operations",
    "relational_division",
    "complex_join",
    "filtering",
    "retrieval",
    "complex",
)

_MAX_IMAGE_PARTS = 4
_MAX_IMAGE_BYTES = 5 * 1024 * 1024  # guardrail against huge payloads
_IMG_SRC_PATTERN = re.compile(r"<img[^>]+src\s*=\s*[\"']([^\"']+)[\"']", re.IGNORECASE)

_EVAL_PATH = Path(__file__).resolve().parent / "docs" / "evaluation.md"
try:
    _EVALUATION_GUIDE = _EVAL_PATH.read_text(encoding="utf-8")
except FileNotFoundError:
    _EVALUATION_GUIDE = ""

_SQL_SYSTEM_PROMPT = """You are an expert SQL assistant. Given an HTML problem definition, PRIORITIZE reading and decoding any images referenced by <img> tags, especially when they point to external URLs (http/https). 
Treat externally linked images as high-priority sources of schema, sample output, or column labels and attempt to fetch/interpret them using available vision/text capabilities before relying on surrounding HTML text.
All problems contain the table(s) info and sample output either in HTML/ images. Use that to construct your SQL solution.
Produce ONLY the final SQL solution solving the problem in the "Nhiệm vụ" section in the problem, meeting these constraints:
1. IMPORTANT: Before writing the query, scan the HTML for any <img> tag. Prioritize external image links (http/https) and use Gemini's native vision/text capabilities to interpret those images and incorporate the decoded text exactly. Capture column labels and ordering from screenshots just as you would from regular HTML.
2. Also look for a field labelled 'Loại Database' or 'Database Type'; if present, switch to that dialect (e.g., MySQL, SQL Server) and note the choice in the header comment.
3. Match exactly the sample output columns (names, order, case) and include ORDER BY when sample ordering is implied.
4. Prefer JOINs over subqueries when clarity improves readability; always terminate statements with a semicolon. Use 1/0 (or 'Y'/'N') instead of TRUE/FALSE when working with BIT columns.
5. Provide header comments in the SQL: first line '-- Tables: <comma-separated tables>' and second line '-- Technique: <primary technique>'. Leave one blank line before SELECT. If a non-default dialect is used, append '(dialect: <name>)' to the Technique line.
6. Do NOT invent columns—derive everything from the schema or sample output (including decoded image text). If an image provides conflicting column names/order vs HTML, prefer the image-derived labels but document the choice in reasoning.
7. For problems that are *not* `modification` section, provide ONLY the SELECT statement, WITH NO CREATE TABLE/ INSERT INTO. For `modification` tasks, provide ONLY the required DML/DDL statement(s).
8. Output MUST be a single-line, minified JSON object with exactly these keys: sql, reasoning.
IMPORTANT RULES MUST FOLLOW:
- sql value MUST be a fenced code block in the form ```sql\n...\n``` using neat indentation and blank lines for readability.
- Do not include backticks or text outside the JSON object.
- DO NOT PERFORM ANY DML/ DDL operations, ANY SQL SYSTEM MODIFICATIONS in the final sql solution field in non-`modification` problem.
"""

_TAXONOMY_SYSTEM_PROMPT = """You are a classification assistant for SQL practice problems. Review ONLY the provided SQL solution (plus optional reasoning) and infer which taxonomy bucket best represents the core technique.
Allowed taxonomy labels (exact spelling): modification, aggregation, grouping_having, pivoting, set_operations, relational_division, complex_join, filtering, retrieval, complex.
The taxonomy evaluation guideline is attached with the prompt, refer strictly to it when making your decision.
Output single-line JSON: {"taxonomy_section": "<label>", "reasoning": "<concise justification>"}. The label MUST be one of the allowed values; never invent new categories.
"""

def _guess_mime_from_url(url: str) -> str:
    parsed = urlparse(url)
    mime, _ = mimetypes.guess_type(parsed.path)
    return mime or "image/png"


def _decode_data_uri(uri: str) -> Tuple[Dict[str, Any] | None, str | None]:
    match = re.match(r"data:([^;,]+)(?:;charset=[^;,]+)?;base64,(.*)", uri, re.IGNOREPCASE | re.DOTALL)
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
    return {"mime_type": mime or "image/png", "data": data}, None


def _fetch_remote_image(url: str) -> Tuple[Dict[str, Any] | None, str | None]:
    req = Request(url, headers={"User-Agent": "Mozilla/5.0"})
    try:
        with urlopen(req, timeout=10) as resp:
            data = resp.read()
            if len(data) > _MAX_IMAGE_BYTES:
                return None, "Remote image exceeds size limit"
            mime = resp.info().get_content_type() or _guess_mime_from_url(url)
            return {"mime_type": mime, "data": data}, None
    except (HTTPError, URLError, TimeoutError) as exc:
        return None, f"Fetch failed: {exc}"
    except Exception as exc:
        return None, f"Unexpected fetch error: {exc}"


def _collect_image_blobs(problem_html: str) -> Tuple[List[Dict[str, Any]], List[str]]:
    blobs: List[Dict[str, Any]] = []
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


def _build_sql_prompt(problem_html: str, problem_id: str, image_notes: List[str] | None = None) -> str:
    parts = [
        f"<ID>{problem_id}</ID>\n",
    ]
    # if _EVALUATION_GUIDE:
    #     parts.append("<EVALUATION_GUIDE>\n")
    #     parts.append(_EVALUATION_GUIDE)
    #     parts.append("\n</EVALUATION_GUIDE>\n")
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

def _build_taxonomy_prompt(
    problem_id: str,
    sql_solution: str,
    reasoning: str | None,
    taxonomy_hint: str | None,
) -> str:
    parts = [
        f"<ID>{problem_id}</ID>\n",
        # f"<CURRENT_HINT>{taxonomy_hint or 'unknown'}</CURRENT_HINT>\n",
        "<ALLOWED_TAXONOMY>\n",
        "\n".join(_TAXONOMY_OPTIONS),
        "\n</ALLOWED_TAXONOMY>\n",
    ]
    if _EVALUATION_GUIDE:
        parts.append("<EVALUATION_GUIDE>\n")
        parts.append(_EVALUATION_GUIDE)
        parts.append("\n</EVALUATION_GUIDE>\n")
    parts.extend([
        "<SQL_SOLUTION>\n",
        sql_solution,
        "\n</SQL_SOLUTION>\n",
    ])
    if reasoning:
        parts.append("<MODEL_REASONING>\n")
        parts.append(reasoning)
        parts.append("\n</MODEL_REASONING>\n")
    parts.append("Return the JSON object now.")
    return "".join(parts)


def _parse_json_payload(t: str) -> Dict[str, Any] | None:
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


def _invoke_model(model, prompt: str, image_blobs: List[Dict[str, Any]] | None = None) -> str:
    payload: List[Any] = [prompt]
    if image_blobs:
        payload.extend(image_blobs)
    response = model.generate_content(payload)
    return response.text.strip()


def _make_model(api_key: str, model_name: str, system_prompt: str):
    kwargs = {"model_name": model_name, "system_instruction": system_prompt}
    try:
        return genai.GenerativeModel(**kwargs, api_key=api_key)
    except TypeError:
        # Older SDKs do not support per-model API keys; fall back to global configure.
        genai.configure(api_key=api_key)
        return genai.GenerativeModel(**kwargs)


@lru_cache(maxsize=2)
def _sql_model():
    return _make_model(_SQL_API_KEY, _SQL_MODEL_NAME, _SQL_SYSTEM_PROMPT)


@lru_cache(maxsize=2)
def _taxonomy_model():
    return _make_model(_TAXONOMY_API_KEY, _TAXONOMY_MODEL_NAME, _TAXONOMY_SYSTEM_PROMPT)


def generate_sql_solution(problem_html: str, problem_id: str, taxonomy_hint: str | None = None) -> Dict[str, str]:
    """Generate a SQL solution using Gemini.

    Parameters
    ----------
    problem_html : str
        Raw HTML content of the problem (already scraped).
    problem_id : str
        Problem code like 'SQL1651'.
    taxonomy_hint : str | None
    Optional hint for classification (e.g., 'aggregation'); model may override.

    Returns
    -------
    Dict[str,str]
        { 'sql': str, 'reasoning': str, 'taxonomy_section': str }
    """
    image_blobs, image_notes = _collect_image_blobs(problem_html)
    prompt = _build_sql_prompt(problem_html, problem_id, image_notes if image_notes else None)
    text = _invoke_model(_sql_model(), prompt, image_blobs)

    data = _parse_json_payload(text)
    if not data or not all(k in data for k in ("sql", "reasoning")):
        # Fallback to raw text as SQL content
        data = {"sql": text, "reasoning": "Non-JSON response; inspect manually."}

    taxonomy_label = classify_taxonomy(
        sql_payload=data.get("sql", ""),
        problem_id=problem_id,
        taxonomy_hint=taxonomy_hint,
        reasoning=data.get("reasoning"),
    )
    data["taxonomy_section"] = taxonomy_label
    return data


def classify_taxonomy(
    sql_payload: str,
    problem_id: str,
    taxonomy_hint: str | None = None,
    *,
    reasoning: str | None = None,
) -> str:
    """Classify a generated SQL solution into the canonical taxonomy labels."""
    prompt = _build_taxonomy_prompt(problem_id, sql_payload or "", reasoning, taxonomy_hint)
    default_label = (taxonomy_hint.strip().lower() if taxonomy_hint else "retrieval")
    try:
        text = _invoke_model(_taxonomy_model(), prompt)
    except Exception as exc:  # pragma: no cover - defensive path for API outages
        return default_label

    parsed = _parse_json_payload(text)
    if parsed and isinstance(parsed, dict):
        label = parsed.get("taxonomy_section")
        if isinstance(label, str) and label.strip().lower() in _TAXONOMY_OPTIONS:
            return label.strip().lower()
    return default_label


__all__ = ["generate_sql_solution", "classify_taxonomy"]
