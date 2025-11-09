-- Problem: SQL2263 - Các quốc gia nào có độ sâu khu vực bảo tồn biển cao nhất và thấp nhất ở các đại dương Bắc Cực và Nam Cực.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
