-- Problem: SQL1764 - Có bao nhiêu nhân viên đã hoàn thành khóa đào tạo về tính đa dạng và hòa nhập trong bộ phận Tiếp thị.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
