import os
import re
import unicodedata
from pathlib import Path

try:
    from bs4 import BeautifulSoup  # optional, improves HTML text extraction
except Exception:
    BeautifulSoup = None

# Mapping of section identifiers (folder names) to keywords or classifier hints
SECTIONS = {
    '01_modification': ['cập nhật', 'xóa', 'chèn', 'insert', 'delete', 'update', 'thêm', 'create table', 'alter', 'drop', 'merge'],
    '02_aggregation_simple': ['tổng số', 'bao nhiêu', 'count', 'average', 'trung bình', 'sum', 'ratio'],
    '03_aggregation_grouped': ['mỗi', 'per', 'theo', 'group', 'by department', 'phân loại', 'category'],
    '04_window_functions': ['top', 'cao nhất', 'lớn nhất', 'nhỏ nhất', 'rank', 'row_number', 'dense_rank', 'lag', 'lead', 'running'],
    '05_pivoting': ['pivot', 'CASE WHEN', 'mùa', 'season', 'matrix', 'cột riêng'],
    '06_set_operations': ['intersect', 'union', 'except', 'both', 'chung', 'loại trừ'],
    '07_relational_division': ['tất cả', 'all', 'cả hai', 'mọi', 'đều', 'all products', 'both categories'],
    '08_range_join': ['khoảng', 'between', 'effective', 'date range', '>=', '<=', 'window của'],
    '09_filtering': ['trong tuần', 'tháng', 'năm', 'gần đây', 'recent', 'ngày', 'date', 'substring', 'trim', 'normalize', 'chuẩn hóa', 'fix name'],
    '10_retrieval': ['liệt kê', 'danh sách', 'join', 'và', 'ở đâu', 'who', 'which'],
    '11_complex': ['thủ tục', 'procedure', 'function', 'phức tạp', 'nhiều bước', 'comprehensive'],
}

TEMPLATE_SNIPPETS = {
    '01_modification': """-- Modification (DML/DDL) template
-- UPDATE example
UPDATE <table>
SET <column> = <expression>
WHERE <condition>;
""",
    '02_aggregation_simple': """-- Simple aggregation template
SELECT COUNT(*) AS total_records
FROM <table>;
""",
    '03_aggregation_grouped': """-- Grouped aggregation template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
""",
    '04_window_functions': """-- Window function template
SELECT * FROM (
  SELECT <partition_col>, <measure>,
         ROW_NUMBER() OVER (PARTITION BY <partition_col> ORDER BY <measure> DESC) rn
  FROM <table>
) ranked
WHERE rn <= <N>;
""",
    '05_pivoting': """-- Conditional aggregation (pivot) template
SELECT <group_col>,
       SUM(CASE WHEN <cond1> THEN <val> ELSE 0 END) AS metric1,
       SUM(CASE WHEN <cond2> THEN <val> ELSE 0 END) AS metric2
FROM <table>
GROUP BY <group_col>;
""",
    '06_set_operations': """-- Set operations template
(SELECT <cols> FROM <table_a>)
INTERSECT
(SELECT <cols> FROM <table_b>);
""",
    '07_relational_division': """-- Relational division template
SELECT entity_id
FROM entity_item
GROUP BY entity_id
HAVING COUNT(DISTINCT item_id) = (
    SELECT COUNT(DISTINCT item_id)
    FROM items
);
""",
    '08_range_join': """-- Range join template
SELECT f.*, p.price
FROM facts f
JOIN prices p ON p.product_id = f.product_id
             AND f.event_date BETWEEN p.start_date AND p.end_date;
""",
    '09_filtering': """-- Filtering template
SELECT *
FROM <table>
WHERE <condition involving dates/strings>;
""",
    '10_retrieval': """-- Basic retrieval template
SELECT <columns>
FROM <table_a> a
JOIN <table_b> b ON b.<fk> = a.<pk>
WHERE <predicate>;
""",
    '11_complex': """-- Complex logic placeholder
-- Combine multiple techniques as required for the problem statement.
SELECT ...;
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
    if any(w in content_lower for w in ['insert', 'update', 'delete', 'chèn', 'cập nhật', 'xóa', 'create table', 'alter table']):
        return '01_modification'
    if any(w in content_lower for w in ['row_number', 'rank', 'dense_rank', 'top 3', 'top 5', 'lag', 'lead']):
        return '04_window_functions'
    if any(w in content_lower for w in ['between', 'effective date', 'hiệu lực', 'start_date', 'end_date']):
        return '08_range_join'
    if any(w in content_lower for w in ['tất cả', 'bought all', 'all products', 'mọi sản phẩm']):
        return '07_relational_division'
    if any(w in content_lower for w in ['không có trong', 'nhưng không', 'except', 'anti join', 'intersect']):
        return '06_set_operations'
    if any(w in content_lower for w in ['viết hoa', 'normalize', 'chuẩn hóa', 'capitalize', 'substring', 'trim']):
        return '09_filtering'
    if 'group by' in content_lower:
        return '03_aggregation_grouped'
    if 'count(' in content_lower or 'sum(' in content_lower:
        return '02_aggregation_simple'
    # Fallbacks based on filename cues
    if 'top' in filename_lower or 'cao nhất' in filename_lower:
        return '04_window_functions'
    if 'trung bình' in filename_lower or 'average' in filename_lower:
        return '02_aggregation_simple'
    return '10_retrieval'

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
    '01_modification': 'Tác vụ DML/DDL (INSERT/UPDATE/DELETE/CREATE). Cần chỉ rõ điều kiện để tránh ảnh hưởng ngoài ý muốn.',
    '02_aggregation_simple': 'Tính toán một tổng hợp duy nhất cho toàn bộ tập dữ liệu (COUNT/SUM/AVG không có GROUP BY).',
    '03_aggregation_grouped': 'Tổng hợp theo nhóm với GROUP BY và các phép đo theo từng partition.',
    '04_window_functions': 'Sử dụng hàm cửa sổ (ROW_NUMBER, RANK, LAG...) để xếp hạng hoặc soi liền kề.',
    '05_pivoting': 'Biến hàng thành cột bằng tổng hợp có điều kiện hoặc PIVOT.',
    '06_set_operations': 'Dùng UNION/INTERSECT/EXCEPT để so sánh hoặc giao/hiệu giữa các tập kết quả.',
    '07_relational_division': 'Bài toán “đã có tất cả” với NOT EXISTS kép hoặc HAVING COUNT bằng tổng yêu cầu.',
    '08_range_join': 'JOIN dựa trên điều kiện bất đẳng thức hoặc khoảng thời gian hiệu lực.',
    '09_filtering': 'Tập trung vào biểu thức WHERE phức tạp: xử lý ngày/thời gian hoặc chuẩn hóa chuỗi.',
    '10_retrieval': 'Truy xuất dữ liệu bằng SELECT/JOIN cơ bản với điều kiện bằng (=).',
    '11_complex': 'Kết hợp nhiều kỹ thuật nâng cao (ví dụ window + pivot) hoặc logic lồng nhau phức tạp.',
}

count = 0
index_entries = []
for entry in PROBLEMS_DIR.iterdir():
    if not entry.name.lower().endswith(('.html','.txt')):
        continue
    content = extract_problem_text(entry)
    section = classify(entry.name.lower(), content)
    template = TEMPLATE_SNIPPETS.get(section, TEMPLATE_SNIPPETS['10_retrieval'])
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
