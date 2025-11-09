import os
import re
import unicodedata
from pathlib import Path

try:
    from bs4 import BeautifulSoup  # optional, improves HTML text extraction
except Exception:
    BeautifulSoup = None

# Mapping of section identifiers (folder names) to keywords or classifier lambdas
SECTIONS = {
    '01_counting_grouping': ['tổng số', 'số lượng', 'count', 'bao nhiêu', 'average', 'trung bình', 'tỷ lệ', 'ratio'],
    '02_filtering_dates': ['trong tuần', 'tháng', 'năm', 'quý', 'gần đây', 'recent', 'ngày', 'date'],
    '03_joins_set': ['cả', 'và', 'cung cấp', 'join', 'có ở', 'ở cả', 'intersection'],
    '04_topn_window': ['top', 'cao nhất', 'lớn nhất', 'nhỏ nhất', 'rank', 'gần đây nhất'],
    '05_conditional_pivot': ['mùa', 'season', 'riêng', 'mỗi mùa', 'pivot'],
    '06_division': ['tất cả', 'all', 'mua toàn bộ', 'có cả A và B'],
    '07_range_join': ['khoảng', 'between', 'effective', 'date range'],
    '08_set_difference': ['không', 'nhưng không', 'either', 'trừ', 'except'],
    '09_window_sequences': ['liên tiếp', 'consecutive', 'sequence'],
    '10_dml': ['cập nhật', 'xóa', 'chèn', 'insert', 'delete', 'update', 'thêm'],
    '11_string_normalization': ['chuẩn hóa', 'fix name', 'viết hoa', 'normalize', 'chỉnh sửa tên'],
}

TEMPLATE_SNIPPETS = {
    '01_counting_grouping': """-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
""",
    '02_filtering_dates': """-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
""",
    '03_joins_set': """-- Join / Set intersection template
SELECT a.<col>, b.<col2>
FROM <table_a> a
JOIN <table_b> b ON b.<fk> = a.<pk>;
""",
    '04_topn_window': """-- Top-N per group (window) template
SELECT * FROM (
  SELECT <partition_col>, <measure>,
         ROW_NUMBER() OVER (PARTITION BY <partition_col> ORDER BY <measure> DESC) rn
  FROM <table>
) t WHERE rn <= <N>;
""",
    '05_conditional_pivot': """-- Conditional aggregation (pivot-like) template
SELECT <group_col>,
       SUM(CASE WHEN <cond1> THEN <val> ELSE 0 END) AS metric1,
       SUM(CASE WHEN <cond2> THEN <val> ELSE 0 END) AS metric2
FROM <table>
GROUP BY <group_col>;
""",
    '06_division': """-- Division (all items) template
SELECT entity_id
FROM entity_item
GROUP BY entity_id
HAVING COUNT(DISTINCT item_id) = (SELECT COUNT(DISTINCT item_id) FROM items);
""",
    '07_range_join': """-- Range join template
SELECT f.*, p.price
FROM facts f
JOIN prices p ON p.product_id = f.product_id
             AND f.event_date BETWEEN p.start_date AND p.end_date;
""",
    '08_set_difference': """-- A but not B template
SELECT a.*
FROM table_a a
LEFT JOIN table_b b ON b.a_id = a.id
WHERE b.a_id IS NULL;
""",
    '09_window_sequences': """-- Consecutive sequence detection template
SELECT DISTINCT val
FROM (
  SELECT val,
         LAG(val,1) OVER (ORDER BY id) AS v1,
         LAG(val,2) OVER (ORDER BY id) AS v2
  FROM logs
) t
WHERE val = v1 AND val = v2;
""",
    '10_dml': """-- DML examples
-- INSERT
INSERT INTO <table>(col1,col2) VALUES (..);
-- UPDATE
UPDATE <table> SET col = expr WHERE condition;
-- DELETE
DELETE FROM <table> WHERE condition;
""",
    '11_string_normalization': """-- String normalization template
SELECT id,
       CONCAT(UPPER(LEFT(name,1)), LOWER(SUBSTRING(name,2))) AS fixed_name
FROM people;
""",
}

PROBLEMS_DIR = Path('problems')
SOLUTIONS_DIR = Path('solutions')

# Ensure base solutions dir
SOLUTIONS_DIR.mkdir(exist_ok=True)
for section in SECTIONS:
    (SOLUTIONS_DIR / section).mkdir(exist_ok=True)

def extract_problem_text(path: Path) -> str:
    """Extract readable text from HTML/.txt for better classification."""
    try:
        raw = path.read_text(encoding='utf-8', errors='ignore')
    except Exception:
        raw = path.read_text(errors='ignore')
    low = raw.lower()
    if path.suffix.lower() == '.html' and BeautifulSoup is not None:
        try:
            soup = BeautifulSoup(raw, 'html.parser')
            text = soup.get_text(separator=' ', strip=True).lower()
            return text
        except Exception:
            return low
    return low


def classify(filename_lower: str, content_lower: str):
    # Prefer content keywords; fallback to filename
    haystacks = [content_lower, filename_lower]
    for hs in haystacks:
        for section, keywords in SECTIONS.items():
            for kw in keywords:
                if kw in hs:
                    return section
    # Strong signals
    if any(w in content_lower for w in ['insert', 'update', 'delete', 'chèn', 'cập nhật', 'xóa']):
        return '10_dml'
    if any(w in content_lower for w in ['consecutive', 'liên tiếp', 'lag', 'lead']):
        return '09_window_sequences'
    if any(w in content_lower for w in ['row_number', 'rank', 'dense_rank', 'top 3', 'top 5', 'top-']):
        return '04_topn_window'
    if any(w in content_lower for w in ['between', 'effective date', 'hiệu lực', 'start_date', 'end_date']):
        return '07_range_join'
    if any(w in content_lower for w in ['tất cả', 'bought all', 'all products', 'mọi sản phẩm']):
        return '06_division'
    if any(w in content_lower for w in ['không có trong', 'nhưng không', 'except', 'anti join']):
        return '08_set_difference'
    if any(w in content_lower for w in ['viết hoa', 'normalize', 'chuẩn hóa', 'capitalize']):
        return '11_string_normalization'
    # Fallback
    if 'top' in filename_lower or 'cao nhất' in filename_lower:
        return '04_topn_window'
    if 'trung bình' in filename_lower or 'average' in filename_lower:
        return '01_counting_grouping'
    return '01_counting_grouping'

# Sanitize filename to .sql
def to_sql_filename(original_name: str) -> str:
    """Preserve original (Vietnamese) problem name as much as possible.
    Strip only characters invalid on Windows: \ / : * ? " < > | and remove trailing dot/space.
    Keep spaces (for readability) and diacritics; replace internal sequences of disallowed chars with a single space.
    Append .sql extension.
    """
    base = original_name.rsplit('.', 1)[0]
    # Remove path separators explicitly
    base = base.replace('\\', ' ').replace('/', ' ')
    # Replace illegal characters with space
    base = re.sub(r'[\:\*\?"<>\|]', ' ', base)
    # Collapse whitespace
    base = re.sub(r'\s+', ' ', base).strip()
    # Windows does not allow names ending with dot or space
    base = base.rstrip(' .')
    # Safeguard empty
    if not base:
        base = 'problem'
    # Keep spaces; final filename
    return base + '.sql'


def _ensure_unique_path(path: Path) -> Path:
    """If path exists, append numeric suffix before extension to avoid overwrite."""
    if not path.exists():
        return path
    stem = path.stem
    suffix = path.suffix
    parent = path.parent
    i = 2
    while True:
        candidate = parent / f"{stem}_{i}{suffix}"
        if not candidate.exists():
            return candidate
        i += 1


RATIONALES = {
    '01_counting_grouping': 'Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.',
    '02_filtering_dates': 'Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.',
    '03_joins_set': 'Kết hợp bảng bằng JOIN để lấy thuộc tính liên quan; giao/hội bằng GROUP BY/HAVING.',
    '04_topn_window': 'Xếp hạng per-group bằng window functions (ROW_NUMBER/RANK) để chọn Top-N.',
    '05_conditional_pivot': 'Tổng hợp điều kiện để tạo cột theo điều kiện (CASE) như pivot.',
    '06_division': 'Bài toán “đã có tất cả” dùng HAVING COUNT(DISTINCT) = tổng mục tiêu.',
    '07_range_join': 'JOIN theo khoảng thời gian hiệu lực: event_date BETWEEN start_date AND end_date.',
    '08_set_difference': 'Anti-join để lấy A không có trong B (LEFT JOIN ... WHERE b.id IS NULL).',
    '09_window_sequences': 'Dò chuỗi liên tiếp bằng LAG/LEAD trên thứ tự xác định.',
    '10_dml': 'Tác vụ DML (INSERT/UPDATE/DELETE) với điều kiện chính xác; cẩn trọng phạm vi.',
    '11_string_normalization': 'Chuẩn hóa chuỗi: viết hoa chữ cái đầu, lower các chữ còn lại, trim.',
}

count = 0
index_entries = []
for entry in PROBLEMS_DIR.iterdir():
    if not entry.name.lower().endswith(('.html','.txt')):
        continue
    content = extract_problem_text(entry)
    section = classify(entry.name.lower(), content)
    template = TEMPLATE_SNIPPETS.get(section, TEMPLATE_SNIPPETS['01_counting_grouping'])
    sql_filename = to_sql_filename(entry.name)
    target_path = SOLUTIONS_DIR / section / sql_filename
    target_path = _ensure_unique_path(target_path)
    rationale = RATIONALES.get(section, '')

    if not target_path.exists():
        header = (
            f"-- Problem: {entry.name}\n"
            f"-- Auto-classified section: {section}\n"
            f"-- Rationale: {rationale}\n"
            f"-- Adjust table/column names before running.\n\n"
        )
        with open(target_path, 'w', encoding='utf-8') as f:
            f.write(header + template)
        count += 1
    else:
        # Augment existing file with rationale header if missing, keep body intact
        try:
            existing = target_path.read_text(encoding='utf-8', errors='ignore')
            if '-- Rationale:' not in existing:
                new_header = (
                    f"-- Problem: {entry.name}\n"
                    f"-- Auto-classified section: {section}\n"
                    f"-- Rationale: {rationale}\n"
                )
                target_path.write_text(new_header + existing, encoding='utf-8')
        except Exception:
            pass

    rel_path = str(target_path.relative_to(SOLUTIONS_DIR)).replace('\\','/')
    index_entries.append((entry.name, section, rel_path))

print(f"Generated {count} solution skeleton(s) into '{SOLUTIONS_DIR}' grouped by sections.")

# Build index file
index_lines = ["# Solutions Index\n\n", "Problem | Section | File\n", "---|---|---\n"]
for name, section, rel in sorted(index_entries, key=lambda x: x[0].lower()):
    index_lines.append(f"{name} | {section} | {rel}\n")

with open(SOLUTIONS_DIR / 'index.md', 'w', encoding='utf-8') as idx:
    idx.writelines(index_lines)
print("Wrote solutions/index.md")
