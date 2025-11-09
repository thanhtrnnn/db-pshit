"""Batch generation script for SQL solutions using Google AI Studio.

Workflow:
1. Iterate over HTML stubs in problems/ matching pattern 'SQL*.html'.
2. Read file content; extract problem_id from filename prefix.
3. Provide a taxonomy hint guess (simple heuristics) based on keywords.
4. Call `generate_sql_solution` (Gemini) to obtain {sql, reasoning, taxonomy_section}.
5. Determine final folder from taxonomy_section (fallback to counting_grouping).
6. Write solution file under `solutions/<section>/<original title>.sql` with cleaned header.
7. Update `solutions/index.md` (append new entry if missing).

Safety:
    Does NOT overwrite existing solution unless --force passed.

Usage (PowerShell):
    python generate_sql_batch.py --limit 3 --force

Note:
    Requires GOOGLE_API_KEY in environment & installed dependencies.
"""
from __future__ import annotations
import argparse
import re
import os
from pathlib import Path
from typing import Tuple
# Note: Import of ai_client is deferred to runtime to support --dry-run without requiring GOOGLE_API_KEY.

ROOT = Path(__file__).parent
PROBLEMS_DIR = ROOT / "problems"
SOLUTIONS_DIR = ROOT / "solutions"
INDEX_FILE = SOLUTIONS_DIR / "index.md"

SECTION_MAP = {
    "dml": "10_dml",
    "topn_window": "04_topn_window",
    "conditional_pivot": "05_conditional_pivot",
    "pivot": "05_conditional_pivot",
    "counting_grouping": "01_counting_grouping",
    "joins_set": "03_joins_set",
    "division": "06_division",
    "set_difference": "08_set_difference",
    "window": "09_window_sequences",
    "filtering_dates": "02_filtering_dates",
    "string_normalization": "11_string_normalization",
    "range_join": "07_range_join",
}

ALLOWED_TAXONOMY = set(SECTION_MAP.keys())

def guess_taxonomy_hint(html: str) -> str:
    lower = html.lower()
    if "update" in lower or "delete" in lower or "insert" in lower:
        return "dml"
    if "row_number" in lower or "over(" in lower:
        return "topn_window"
    if "pivot" in lower or "season" in lower or "case when" in lower:
        return "conditional_pivot"
    if re.search(r"count\s*\(", lower):
        return "counting_grouping"
    if "intersect" in lower or "except" in lower:
        return "set_difference"
    if re.search(r"year|month|dateadd|datediff|getdate|to_date|date\(", lower):
        return "filtering_dates"
    if re.search(r"upper\(|lower\(|trim\(|replace\(|regexp", lower):
        return "string_normalization"
    return "counting_grouping"

def normalize_taxonomy(raw: str, fallback_hint: str) -> str:
    r = (raw or '').strip().lower()
    if r in ALLOWED_TAXONOMY:
        return r
    synonyms = {
        "window_functions": "topn_window",
        "window": "topn_window",
        "pivoting": "conditional_pivot",
        "filtering": "filtering_dates",
        "date_filtering": "filtering_dates",
        "string": "string_normalization",
        "normalization": "string_normalization",
        "range": "range_join",
        "join_range": "range_join",
        "grouping": "counting_grouping",
    }
    if r in synonyms:
        return synonyms[r]
    # fallback precedence: dml > topn_window > conditional_pivot > counting_grouping > joins_set
    if fallback_hint in ALLOWED_TAXONOMY:
        return fallback_hint
    return "counting_grouping"

def parse_problem_id(filename: str) -> str:
    m = re.match(r"(SQL\d+)", filename)
    return m.group(1) if m else "UNKNOWN"

def ensure_index_header():
    if not INDEX_FILE.exists():
        INDEX_FILE.write_text("# Solutions Index\n\nProblem | Section | File\n---|---|---\n")

def index_has_entry(problem_html_name: str) -> bool:
    if not INDEX_FILE.exists():
        return False
    return problem_html_name in INDEX_FILE.read_text(encoding="utf-8")

def append_index_row(problem_html_name: str, section: str, solution_rel_path: str):
    with INDEX_FILE.open("a", encoding="utf-8") as f:
        f.write(f"{problem_html_name} | {section} | {solution_rel_path}\n")

def remove_index_rows(problem_html_name: str):
    """Remove all index rows for a given problem name while preserving header."""
    if not INDEX_FILE.exists():
        return
    lines = INDEX_FILE.read_text(encoding="utf-8").splitlines()
    out_lines = []
    for i, line in enumerate(lines):
        # Preserve the first three header lines (title and markdown table header)
        if i < 3:
            out_lines.append(line)
            continue
        if not line.startswith(f"{problem_html_name} |"):
            out_lines.append(line)
    INDEX_FILE.write_text("\n".join(out_lines) + "\n", encoding="utf-8")

def _strip_code_fences(sql_text: str) -> str:
    # Remove ```sql ... ``` or ``` ... ``` fences if present at top-level
    import re
    m = re.match(r"\s*```(?:sql)?\s*([\s\S]*?)\s*```\s*\Z", sql_text, re.IGNORECASE)
    return m.group(1) if m else sql_text


def write_solution(section_folder: str, original_html_filename: str, sql_text: str):
    solution_name = original_html_filename.replace(".html", ".sql")
    out_dir = SOLUTIONS_DIR / section_folder
    out_dir.mkdir(parents=True, exist_ok=True)
    target = out_dir / solution_name
    cleaned = _strip_code_fences(sql_text).replace("\r", "")
    target.write_text(cleaned, encoding="utf-8")
    return target

def _mock_generate_sql_solution(problem_html: str, problem_id: str, taxonomy_hint: str) -> dict:
    """Return a deterministic placeholder without calling external APIs.

    Used when --dry-run is enabled to test the end-to-end pipeline safely.
    """
    header = (
        f"-- [DRY RUN PLACEHOLDER]\n"
        f"-- Problem: {problem_id}\n"
        f"-- Taxonomy (hint): {taxonomy_hint}\n"
        f"-- This is a scaffold to verify file paths and index updates.\n"
        f"-- Replace with real SQL via Google AI Studio when ready.\n\n"
    )
    sql = header + "SELECT 1 AS placeholder;\n"
    return {"sql": sql, "reasoning": "dry-run", "taxonomy_section": taxonomy_hint}


def main(limit: int, force: bool, dry_run: bool, replace_index: bool):
    ensure_index_header()
    html_files = sorted(p for p in PROBLEMS_DIR.glob("SQL*.html"))
    processed = 0
    for html_path in html_files:
        if limit and processed >= limit:
            break
        problem_html_name = html_path.name
        problem_id = parse_problem_id(problem_html_name)

        # Skip if already present and not forcing nor replacing index
        if index_has_entry(problem_html_name) and not (force or replace_index):
            continue

        html_content = html_path.read_text(encoding="utf-8")
        taxonomy_hint = guess_taxonomy_hint(html_content)
        if dry_run:
            data = _mock_generate_sql_solution(html_content, problem_id, taxonomy_hint)
        else:
            # Lazy import to avoid requiring GOOGLE_API_KEY during dry runs
            from ai_client import generate_sql_solution  # type: ignore
            data = generate_sql_solution(html_content, problem_id, taxonomy_hint)
        taxonomy_section_raw = data.get("taxonomy_section", taxonomy_hint)
        taxonomy_section = normalize_taxonomy(taxonomy_section_raw, taxonomy_hint)
        section_folder = SECTION_MAP.get(taxonomy_section, SECTION_MAP.get(taxonomy_hint, "01_counting_grouping"))
        if replace_index:
            remove_index_rows(problem_html_name)
        solution_path = write_solution(section_folder, problem_html_name, data["sql"])
        rel_path = f"{section_folder}/{solution_path.name}"
        append_index_row(problem_html_name, section_folder, rel_path)
        processed += 1
        print(f"Generated {problem_id} -> {rel_path} (section={section_folder})")

    print(f"Done. Generated {processed} solutions.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate SQL solutions using Google AI Studio")
    parser.add_argument("--limit", type=int, default=5, help="Max number of problems to process")
    parser.add_argument("--force", action="store_true", help="Regenerate even if index entry exists")
    parser.add_argument("--dry-run", action="store_true", help="Do not call external API; write placeholder SQL to test pipeline")
    parser.add_argument("--replace-index", action="store_true", help="Replace existing index rows for a problem instead of appending duplicates")
    args = parser.parse_args()
    main(limit=args.limit, force=args.force, dry_run=args.dry_run, replace_index=args.replace_index)
