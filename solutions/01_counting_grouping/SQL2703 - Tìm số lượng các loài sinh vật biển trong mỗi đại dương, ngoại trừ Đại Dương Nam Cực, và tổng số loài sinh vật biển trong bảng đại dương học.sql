-- Problem: SQL2703 - Tìm số lượng các loài sinh vật biển trong mỗi đại dương, ngoại trừ Đại Dương Nam Cực, và tổng số loài sinh vật biển trong bảng đại dương học..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
