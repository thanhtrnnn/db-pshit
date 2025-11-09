-- Problem: SQL2287 - Có bao nhiêu người dùng tham gia chuyến tham quan ảo các khách sạn ở 'CityC' trong 30 ngày qua.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
