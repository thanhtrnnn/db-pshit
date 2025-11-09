-- Problem: SQL2163 - Liệt kê tất cả các loài trong bảng cô lập carbon có giá trị cô lập CO2 cao hơn mức cô lập CO2 trung bình.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
