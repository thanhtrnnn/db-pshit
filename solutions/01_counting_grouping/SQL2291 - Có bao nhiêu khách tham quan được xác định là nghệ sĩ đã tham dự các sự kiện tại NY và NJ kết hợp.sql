-- Problem: SQL2291 - Có bao nhiêu khách tham quan được xác định là nghệ sĩ đã tham dự các sự kiện tại NY và NJ kết hợp.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
