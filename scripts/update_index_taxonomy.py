"""Utility to harmonize solutions/index.md with the latest taxonomy folders."""
from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
INDEX_PATH = ROOT / "solutions" / "index.md"

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

ALIASES = {
    "01_modification": "modification",
    "01_counting": "aggregation_simple",
    "01_counting_grouping": "aggregation_grouped",
    "02_aggregation_simple": "aggregation_simple",
    "02_grouping": "aggregation_grouped",
    "03_aggregation_grouped": "aggregation_grouped",
    "03_joins_simple": "retrieval",
    "04_topn_window": "window_functions",
    "04_window_functions": "window_functions",
    "04_filtering_dates": "filtering",
    "05_conditional_pivot": "pivoting",
    "05_string_normalization": "filtering",
    "05_pivoting": "pivoting",
    "06_set_difference": "set_operations",
    "06_range_join": "range_join",
    "07_relational_division": "relational_division",
    "07_set_difference": "set_operations",
    "08_division": "relational_division",
    "08_range_join": "range_join",
    "09_topn_window": "window_functions",
    "09_filtering": "filtering",
    "09_dml": "modification",
    "10_conditional_pivot": "pivoting",
    "10_string_normalization": "filtering",
    "10_retrieval": "retrieval",
    "11_grouping": "aggregation_grouped",
    "11_dml": "modification",
    "11_string_normalization": "filtering",
    "11_complex": "complex",
    "12_mixed": "complex",
    "dml": "modification",
    "counting": "aggregation_simple",
    "grouping": "aggregation_grouped",
    "counting_grouping": "aggregation_grouped",
    "joins_simple": "retrieval",
    "topn_window": "window_functions",
    "conditional_pivot": "pivoting",
    "set_difference": "set_operations",
    "division": "relational_division",
    "range_join": "range_join",
    "filtering_dates": "filtering",
    "string_normalization": "filtering",
    "mixed": "complex",
}

DEFAULT_AGG_SECTION = "aggregation_grouped"


def detect_counting_or_grouping(sql_path: Path) -> str:
    try:
        text = sql_path.read_text(encoding="utf-8").lower()
    except FileNotFoundError:
        return DEFAULT_AGG_SECTION
    if "group by" in text:
        return "aggregation_grouped"
    return "aggregation_simple"


def harmonize_index() -> None:
    if not INDEX_PATH.exists():
        raise FileNotFoundError(f"Cannot find index file at {INDEX_PATH}")

    lines = INDEX_PATH.read_text(encoding="utf-8").splitlines()
    header = ["# Solutions Index", "", "Problem | Section | File", "---|---|---"]
    body_start = 4 if len(lines) >= 4 else 0
    body = lines[body_start:]
    new_lines = header.copy()

    for raw_line in body:
        if not raw_line.strip():
            new_lines.append(raw_line)
            continue
        parts = [p.strip() for p in raw_line.split("|")]
        if len(parts) != 3:
            new_lines.append(raw_line)
            continue
        problem, section_label, rel_path = parts
        canonical = ALIASES.get(section_label, section_label)
        sql_basename = Path(rel_path).name
        sql_path = ROOT / "solutions" / Path(rel_path)

        if canonical in {"aggregation_simple", "aggregation_grouped", "counting_grouping"}:
            canonical = detect_counting_or_grouping(sql_path)
        if sql_path.exists():
            lowered = sql_path.read_text(encoding="utf-8", errors="ignore").lower()
            if any(keyword in lowered for keyword in (" insert ", " update ", " delete ", " merge ", " create ", " alter ", " drop ")):
                canonical = "modification"
        if canonical not in SECTION_MAP:
            canonical = "retrieval"

        folder = SECTION_MAP[canonical]
        new_rel_path = f"{folder}/{sql_basename}"
        new_lines.append(f"{problem} | {canonical} | {new_rel_path}")

    INDEX_PATH.write_text("\n".join(new_lines) + "\n", encoding="utf-8")


if __name__ == "__main__":
    harmonize_index()
