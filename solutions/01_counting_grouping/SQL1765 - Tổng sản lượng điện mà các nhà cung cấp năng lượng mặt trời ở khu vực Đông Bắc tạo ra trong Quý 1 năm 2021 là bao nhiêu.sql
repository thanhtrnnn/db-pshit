-- Problem: SQL1765 - Tổng sản lượng điện mà các nhà cung cấp năng lượng mặt trời ở khu vực Đông Bắc tạo ra trong Quý 1 năm 2021 là bao nhiêu.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
