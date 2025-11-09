-- Problem: SQL1823 - Có bao nhiêu thử nghiệm lâm sàng đối với 'DrugB' ở khu vực Châu Âu từ năm 2018 đến năm 2020.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
