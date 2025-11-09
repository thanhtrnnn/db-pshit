-- Problem: SQL1760 - Xác định số lượng xe tay ga điện tử dùng chung có sẵn ở Paris và Thành phố New York kể từ ngày 1 tháng 1 năm 2022..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
