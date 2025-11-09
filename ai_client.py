"""Google AI Studio (Gemini) client utilities for generating SQL solutions.

Responsibilities:
1. Initialize Gemini model using API key from environment (.env via python-dotenv)
2. Provide a function `generate_sql_solution(problem_html:str, problem_id:str, taxonomy_hint:str)`
   that returns a structured dict with fields: {sql, reasoning, taxonomy_section}
3. Apply repository conventions: header comments, dialect default (SQL Server), fallback notes.

Usage:
    from ai_client import generate_sql_solution
    sql_data = generate_sql_solution(html_text, "SQL1651", "counting_grouping")
    print(sql_data["sql"])

Security:
    The API key must be set as GOOGLE_API_KEY in environment; do not hardcode keys.
"""
from __future__ import annotations
import os
from typing import Dict
import re
import json

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

_SYSTEM_PROMPT = (
    "You are an expert SQL assistant. Given an HTML problem definition extracted from PTIT, "
    "produce ONLY the final SQL solution meeting these constraints: \n"
    "1. Default dialect: SQL Server/T-SQL (use TOP, GETDATE(), DATEADD, DATEDIFF, ISNULL, CONCAT, etc.).\n"
    "2. Match exactly the sample output columns (names, order, case) and include ORDER BY when sample ordering is implied.\n"
    "3. Prefer JOINs over subqueries when clarity improves readability; always terminate statements with a semicolon.\n"
    "   Use 1/0 (or 'Y'/'N') instead of TRUE/FALSE when working with BIT columns.\n"
    "4. Provide header comments in the SQL: first line '-- Tables: <comma-separated tables>' and second line '-- Technique: <primary technique>'. Leave one blank line before SELECT.\n"
    "5. taxonomy_section MUST be one of the following (choose the dominant technique): dml, topn_window, conditional_pivot, counting_grouping, joins_set, division, set_difference, filtering_dates, string_normalization, range_join, window.\n"
    "   dml = INSERT/UPDATE/DELETE/MERGE.\n"
    "   topn_window = ROW_NUMBER / RANK / DENSE_RANK or general window ranking.\n"
    "   conditional_pivot = CASE-based pivots, conditional aggregation, or PIVOT.\n"
    "   counting_grouping = GROUP BY, SUM/COUNT aggregations without pivots.\n"
    "   joins_set = JOIN logic, EXISTS/NOT EXISTS, set membership without aggregation focus.\n"
    "   division = Relational division queries (customers who bought all products).\n"
    "   set_difference = INTERSECT/EXCEPT style requests.\n"
    "   filtering_dates = Date comparisons, rolling windows, or heavy DATEADD/DATEDIFF filters.\n"
    "   string_normalization = TRIM/UPPER/LOWER/REPLACE/token cleanup focus.\n"
    "   range_join = BETWEEN or range-overlapping joins.\n"
    "   window = Other window functions (SUM OVER, AVG OVER) not covered by topn_window.\n"
    "6. If you use INTERSECT/EXCEPT or other ANSI set ops, add a comment with a SQL Server-friendly alternative if needed.\n"
    "7. Do NOT invent columns—derive everything from the schema or sample output.\n"
    "8. Output MUST be a single-line, minified JSON object with exactly these keys: sql, reasoning, taxonomy_section.\n"
    "   - sql value MUST be a fenced code block in the form ```sql\n...\n``` using neat indentation and blank lines for readability.\n"
    "   - Do not include backticks or text outside the JSON object.\n"
)

def _build_prompt(problem_html: str, problem_id: str, taxonomy_hint: str | None) -> str:
    return (
        f"<ID>{problem_id}</ID>\n"
        f"<TAXONOMY_HINT>{taxonomy_hint or 'unknown'}</TAXONOMY_HINT>\n"
        "<PROBLEM_HTML>\n" + problem_html + "\n</PROBLEM_HTML>\n"
        "Produce output JSON now."
    )

def generate_sql_solution(problem_html: str, problem_id: str, taxonomy_hint: str | None = None) -> Dict[str, str]:
    """Generate a SQL solution using Gemini.

    Parameters
    ----------
    problem_html : str
        Raw HTML content of the problem (already scraped).
    problem_id : str
        Problem code like 'SQL1651'.
    taxonomy_hint : str | None
        Optional hint for classification (e.g., 'counting_grouping'); model may override.

    Returns
    -------
    Dict[str,str]
        { 'sql': str, 'reasoning': str, 'taxonomy_section': str }
    """
    prompt = _build_prompt(problem_html, problem_id, taxonomy_hint)
    model = genai.GenerativeModel(_MODEL_NAME, system_instruction=_SYSTEM_PROMPT)
    response = model.generate_content(prompt)
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
