-- Problem: SQL1859 - Liệt kê tất cả các nhà cung cấp và số lượng quần áo họ cung cấp cho bộ sưu tập Xuân 2023, xếp theo số lượng quần áo được cung cấp..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
