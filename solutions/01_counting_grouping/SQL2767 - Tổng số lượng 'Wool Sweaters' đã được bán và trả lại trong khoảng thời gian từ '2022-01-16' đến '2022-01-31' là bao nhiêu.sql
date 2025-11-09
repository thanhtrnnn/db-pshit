-- Problem: SQL2767 - Tổng số lượng 'Wool Sweaters' đã được bán và trả lại trong khoảng thời gian từ '2022-01-16' đến '2022-01-31' là bao nhiêu.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
