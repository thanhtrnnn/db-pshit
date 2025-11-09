-- Problem: SQL1987 - Đếm số lượng loài sinh vật biển trong mỗi lưu vực đại dương, không bao gồm các loài có tình trạng bảo tồn 'Ít quan tâm'.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
