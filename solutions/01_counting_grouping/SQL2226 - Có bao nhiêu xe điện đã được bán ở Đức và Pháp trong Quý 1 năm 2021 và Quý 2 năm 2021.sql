-- Problem: SQL2226 - Có bao nhiêu xe điện đã được bán ở Đức và Pháp trong Quý 1 năm 2021 và Quý 2 năm 2021.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
