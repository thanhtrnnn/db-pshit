"""Batch generation script for SQL solutions using Google AI Studio.

Workflow:
1. Iterate over HTML stubs in problems/ matching pattern 'SQL*.html'.
2. Read file content; extract problem_id from filename prefix.
3. Provide a taxonomy hint guess (simple heuristics) based on keywords.
4. Call `generate_sql_solution` (Gemini) to obtain {sql, reasoning, taxonomy_section}.
5. Determine final folder from taxonomy_section (fallback to retrieval).
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
import time
# Note: Import of ai_client is deferred to runtime to support --dry-run without requiring GOOGLE_API_KEY.

ROOT = Path(__file__).parent
PROBLEMS_DIR = ROOT / "problems"
SOLUTIONS_DIR = ROOT / "solutions"
INDEX_FILE = SOLUTIONS_DIR / "index.md"
IGNORE_FILE = ROOT / "ignore.txt"

SECTION_MAP = {
    "modification": "01_modification",
    "aggregation_simple": "02_aggregation_simple",
    "aggregation_grouped": "03_aggregation_grouped",
    "window_functions": "04_window_functions",
    "pivoting": "05_pivoting",
    "set_operations": "06_set_operations",
    "relational_division": "07_relational_division",
    "range_join": "08_range_join",
    "filtering": "09_filtering",
    "retrieval": "10_retrieval",
    "complex": "11_complex",
}

ALLOWED_TAXONOMY = set(SECTION_MAP.keys())

def load_ignored_problems() -> set[str]:
    """Load set of problem IDs to ignore from ignore.txt."""
    ignored = set()
    if IGNORE_FILE.exists():
        with IGNORE_FILE.open(encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if line:
                    # Extract problem ID like SQL94
                    m = re.match(r"(SQL-?\d+)", line)
                    if m:
                        ignored.add(m.group(1))
    return ignored

def add_to_ignore(problem_id: str):
    """Append problem_id to ignore.txt if not already present."""
    if not IGNORE_FILE.exists():
        IGNORE_FILE.write_text("", encoding="utf-8")
    with IGNORE_FILE.open("r+", encoding="utf-8") as f:
        lines = f.readlines()
        if any(problem_id in line for line in lines):
            return  # Already ignored
        f.write(f"{problem_id}\n")

def guess_taxonomy_hint(html: str) -> str:
    lower = html.lower()
    if any(k in lower for k in ("insert", "update", "delete", "create table", "alter table", "drop table", " merge ")):
        return "modification"
    if re.search(r"\bover\s*\(", lower) or any(func in lower for func in ("row_number", "dense_rank", "lag", "lead")):
        return "window_functions"
    if "sum(case" in lower or " pivot" in lower:
        return "pivoting"
    if any(op in lower for op in (" union ", "intersect", " except")):
        return "set_operations"
    if (" not exists" in lower and (" all " in lower or " every " in lower)) or "having count" in lower and "distinct" in lower:
        return "relational_division"
    if " between " in lower and " join " in lower:
        return "range_join"
    if re.search(r"dateadd|datediff|getdate|extract\(|to_date|interval|year\(|month\(|day\(|datediff", lower):
        return "filtering"
    if re.search(r"upper\(|lower\(|trim\(|substring\(|replace\(|regexp|len\(", lower):
        return "filtering"
    if "group by" in lower:
        return "aggregation_grouped"
    if re.search(r"count\s*\(|sum\s*\(|avg\s*\(|min\s*\(|max\s*\(", lower):
        return "aggregation_simple"
    if " join " in lower or " exists" in lower or " in (" in lower:
        return "retrieval"
    return "retrieval"

def _canonical_taxonomy(name: str | None) -> str | None:
    if not name:
        return None
    cleaned = name.strip().lower().replace("-", "_").replace(" ", "_")
    if cleaned in ALLOWED_TAXONOMY:
        return cleaned
    synonyms = {
        "dml": "modification",
        "ddl": "modification",
        "counting": "aggregation_simple",
        "aggregation": "aggregation_grouped",
        "aggregations": "aggregation_grouped",
        "counting_grouping": "aggregation_grouped",
        "grouping": "aggregation_grouped",
        "topn_window": "window_functions",
        "window": "window_functions",
        "windowing": "window_functions",
        "window_functions": "window_functions",
        "conditional_pivot": "pivoting",
        "pivot": "pivoting",
        "pivoting": "pivoting",
        "set_difference": "set_operations",
        "set": "set_operations",
        "set_logic": "set_operations",
        "division": "relational_division",
        "range": "range_join",
        "join_range": "range_join",
        "range_join": "range_join",
        "filtering_dates": "filtering",
        "string_normalization": "filtering",
        "date_filtering": "filtering",
        "filtering": "filtering",
        "joins": "retrieval",
        "joins_simple": "retrieval",
        "join": "retrieval",
        "mixed": "complex",
    }
    if cleaned in synonyms:
        mapped = synonyms[cleaned]
        if mapped in ALLOWED_TAXONOMY:
            return mapped
    return None


def normalize_taxonomy(raw: str, fallback_hint: str) -> str:
    primary = _canonical_taxonomy(raw)
    if primary:
        return primary
    fallback = _canonical_taxonomy(fallback_hint)
    if fallback:
        return fallback
    return "retrieval"

def parse_problem_id(filename: str) -> str:
    m = re.match(r"(SQL-?\d+)", filename, re.IGNORECASE)
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
    ignored_problems = load_ignored_problems()
    html_files = sorted(p for p in PROBLEMS_DIR.glob("SQL*.html"))
    processed = 0
    for html_path in html_files:
        if limit and processed >= limit:
            break
        problem_html_name = html_path.name
        problem_id = parse_problem_id(problem_html_name)

        if problem_id in ignored_problems:
            continue  # Skip ignored problems

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
            time.sleep(6)  # Cooldown to withstand rate limits
        taxonomy_section_raw = data.get("taxonomy_section", taxonomy_hint)
        taxonomy_section = normalize_taxonomy(taxonomy_section_raw, taxonomy_hint)
        if taxonomy_section not in SECTION_MAP:
            taxonomy_section = normalize_taxonomy(taxonomy_hint, "retrieval")
        if taxonomy_section not in SECTION_MAP:
            taxonomy_section = "retrieval"
        section_folder = SECTION_MAP.get(taxonomy_section, SECTION_MAP["retrieval"])
        if replace_index:
            remove_index_rows(problem_html_name)
        solution_path = write_solution(section_folder, problem_html_name, data["sql"])
        rel_path = f"{section_folder}/{solution_path.name}"
        append_index_row(problem_html_name, taxonomy_section, rel_path)
        if not dry_run:
            add_to_ignore(problem_id)
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
