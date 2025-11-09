"""Parse batch1.md (Markdown) and update SQL solution files.

We detect headings like '### 10. SQL103 - ...' followed by a fenced ```sql block.
The code fence content is written verbatim (trimmed) into matching solution files.
Multiple fences under the same heading are concatenated separated by blank lines.
Fallback: if a heading exists without a code fence (e.g. placeholder //), skip.
"""

from __future__ import annotations
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MD_FILE = ROOT / "batch1.md"
SOL_DIR = ROOT / "solutions"

HEADING_RE = re.compile(r"^###\s+(\d+)\.\s+SQL(\d+)\s*-\s*(.+)$")
FENCE_START_RE = re.compile(r"^```sql\s*$", re.IGNORECASE)
FENCE_END_RE = re.compile(r"^```\s*$")


def read_md() -> list[str]:
    if not MD_FILE.exists():
        raise FileNotFoundError(f"Markdown batch file not found: {MD_FILE}")
    return MD_FILE.read_text(encoding="utf-8", errors="ignore").splitlines()


def gather_entries(lines: list[str]):
    entries = []
    current = None
    in_fence = False
    buf = []
    for line in lines:
        m = HEADING_RE.match(line)
        if m and not in_fence:
            if current:
                if buf:
                    current["blocks"].append("\n".join(buf).strip())
                    buf.clear()
                entries.append(current)
            current = {"ordinal": int(m.group(1)), "sql_id": m.group(2), "title": m.group(3).strip(), "blocks": []}
            continue
        if current is None:
            continue
        if FENCE_START_RE.match(line):
            in_fence = True
            buf = []
            continue
        if in_fence and FENCE_END_RE.match(line):
            in_fence = False
            current["blocks"].append("\n".join(buf).strip())
            buf = []
            continue
        if in_fence:
            buf.append(line)
    # flush last
    if current:
        if buf:
            current["blocks"].append("\n".join(buf).strip())
        entries.append(current)
    return entries


def find_solution_files(sql_id: str):
    prefix = f"SQL{sql_id}"
    matches = [p for p in SOL_DIR.rglob("*.sql") if p.name.startswith(prefix)]
    return matches


def write_solution(path: Path, title: str, blocks: list[str]):
    if not blocks:
        return False
    header = f"-- Imported from batch1.md\n-- Title: {title}\n\n"
    body = "\n\n".join(b for b in blocks if b)
    # ensure every statement ends with semicolon unless already ended by ; or ) ; pattern
    # naive approach: add semicolon if last non-whitespace char not in ;
    lines = []
    for raw in body.splitlines():
        lines.append(raw.rstrip())
    content = "\n".join(lines).strip()
    path.write_text(header + content + ("\n" if not content.endswith("\n") else ""), encoding="utf-8")
    return True


def main():
    lines = read_md()
    entries = gather_entries(lines)
    updated = 0
    missing = []
    skipped = []
    for e in entries:
        sql_id = e["sql_id"]
        title = e["title"]
        blocks = e["blocks"]
        files = find_solution_files(sql_id)
        if not files:
            missing.append((sql_id, title))
            continue
        if not blocks:
            skipped.append((sql_id, title))
            continue
        for f in files:
            if write_solution(f, title, blocks):
                updated += 1
    print(f"Updated {updated} files.")
    if skipped:
        print("Headings without SQL blocks (skipped):")
        for sid, t in skipped:
            print(f"  SQL{sid} - {t}")
    if missing:
        print("No solution files found for:")
        for sid, t in missing:
            print(f"  SQL{sid} - {t}")


if __name__ == "__main__":
    main()
