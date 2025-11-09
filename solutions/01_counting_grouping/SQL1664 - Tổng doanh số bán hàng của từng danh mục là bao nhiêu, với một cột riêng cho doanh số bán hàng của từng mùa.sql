-- Problem: SQL1664 - Tổng doanh số bán hàng của từng danh mục là bao nhiêu, với một cột riêng cho doanh số bán hàng của từng mùa.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
