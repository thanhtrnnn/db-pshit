-- Problem: SQL2777 - Liệt kê các ngân hàng có số lượng chương trình năng lực tài chính được cung cấp nhiều nhất trong Quý 1 năm 2022, theo thứ tự giảm dần.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
