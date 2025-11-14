"""Utility to harmonize solutions/index.md with the latest taxonomy folders."""
from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SOLUTIONS_DIR = ROOT / "solutions"
INDEX_PATH = SOLUTIONS_DIR / "index.md"

SECTION_MAP = {
    "modification": "01_modification",
    "aggregation": "02_aggregation",
    "window_functions": "03_window_functions",
    "pivoting": "04_pivoting",
    "set_operations": "05_set_operations",
    "relational_division": "06_relational_division",
    "complex_join": "07_complex_join",
    "filtering": "08_filtering",
    "retrieval": "09_retrieval",
    "complex": "10_complex",
}

FOLDER_TO_SECTION = {folder: label for label, folder in SECTION_MAP.items()}

ALIASES = {
    "01_modification": "modification",
    "01_counting": "aggregation",
    "01_counting_grouping": "aggregation",
    "02_aggregation_simple": "aggregation",
    "02_grouping": "aggregation",
    "03_aggregation_grouped": "aggregation",
    "03_joins_simple": "retrieval",
    "04_topn_window": "window_functions",
    "04_window_functions": "window_functions",
    "04_filtering_dates": "filtering",
    "05_conditional_pivot": "pivoting",
    "05_string_normalization": "filtering",
    "05_pivoting": "pivoting",
    "06_set_difference": "set_operations",
    "06_complex_join": "complex_join",
    "07_relational_division": "relational_division",
    "07_set_difference": "set_operations",
    "08_division": "relational_division",
    "08_complex_join": "complex_join",
    "09_topn_window": "window_functions",
    "09_filtering": "filtering",
    "09_dml": "modification",
    "10_conditional_pivot": "pivoting",
    "10_string_normalization": "filtering",
    "10_retrieval": "retrieval",
    "11_grouping": "aggregation",
    "11_dml": "modification",
    "11_string_normalization": "filtering",
    "11_complex": "complex",
    "12_mixed": "complex",
    "dml": "modification",
    "counting": "aggregation",
    "grouping": "aggregation",
    "counting_grouping": "aggregation",
    "joins_simple": "retrieval",
    "topn_window": "window_functions",
    "conditional_pivot": "pivoting",
    "set_difference": "set_operations",
    "division": "relational_division",
    "complex_join": "complex_join",
    "filtering_dates": "filtering",
    "string_normalization": "filtering",
    "mixed": "complex",
}

DEFAULT_AGG_SECTION = "aggregation"


def detect_counting_or_grouping(sql_path: Path) -> str:
    try:
        text = sql_path.read_text(encoding="utf-8").lower()
    except FileNotFoundError:
        return DEFAULT_AGG_SECTION
    if "group by" in text:
        return "aggregation"
    return "aggregation"


def _folder_to_section(folder_name: str | None) -> str | None:
    if not folder_name:
        return None
    folder_name = folder_name.strip()
    if folder_name in FOLDER_TO_SECTION:
        return FOLDER_TO_SECTION[folder_name]
    alias = ALIASES.get(folder_name)
    if alias in SECTION_MAP:
        return alias
    return None


def _resolve_sql_path(rel_path: str, basename: str) -> Path | None:
    candidate = SOLUTIONS_DIR / Path(rel_path)
    if candidate.exists():
        return candidate
    matches = list(SOLUTIONS_DIR.rglob(basename))
    return matches[0] if matches else None


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
        rel_path = rel_path.replace("\\", "/")
        rel_path_obj = Path(rel_path)
        sql_basename = rel_path_obj.name
        sql_path = _resolve_sql_path(rel_path, sql_basename)
        canonical = None
        normalized_rel_path = rel_path_obj.as_posix()

        if sql_path:
            relative = sql_path.relative_to(SOLUTIONS_DIR)
            normalized_rel_path = relative.as_posix()
            folder_name = relative.parts[0] if relative.parts else None
            canonical = _folder_to_section(folder_name)

        if not canonical:
            canonical = ALIASES.get(section_label, section_label)

        if canonical in {"aggregation_simple", "aggregation_grouped", "counting_grouping", "aggregation"}:
            target_path = sql_path or (SOLUTIONS_DIR / normalized_rel_path)
            canonical = detect_counting_or_grouping(target_path)

        if sql_path:
            lowered = sql_path.read_text(encoding="utf-8", errors="ignore").lower()
            if any(keyword in lowered for keyword in (" insert ", " update ", " delete ", " merge ", " create ", " alter ", " drop ")):
                canonical = "modification"

        if canonical not in SECTION_MAP:
            canonical = "retrieval"

        if not sql_path:
            folder = SECTION_MAP[canonical]
            normalized_rel_path = f"{folder}/{sql_basename}"

        new_lines.append(f"{problem} | {canonical} | {normalized_rel_path}")

    INDEX_PATH.write_text("\n".join(new_lines) + "\n", encoding="utf-8")


if __name__ == "__main__":
    harmonize_index()
