-- Problem: SQL2290 - Xác định tên những người nông dân trồng cây với giai đoạn sinh trưởng là “Harvest” nhưng không sử dụng phương pháp Drip irrigation..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
