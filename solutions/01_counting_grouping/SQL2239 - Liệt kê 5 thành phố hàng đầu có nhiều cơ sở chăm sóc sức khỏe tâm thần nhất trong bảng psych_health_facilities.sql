-- Problem: SQL2239 - Liệt kê 5 thành phố hàng đầu có nhiều cơ sở chăm sóc sức khỏe tâm thần nhất trong bảng psych_health_facilities..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
