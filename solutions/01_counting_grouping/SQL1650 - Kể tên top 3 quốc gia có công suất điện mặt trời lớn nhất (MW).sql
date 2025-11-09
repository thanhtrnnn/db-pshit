-- SQL1650: Top 3 quốc gia có tổng công suất điện mặt trời lớn nhất (MW)
-- Bảng: solar_farms(farm_name, country, capacity)
-- Output: country | total_capacity (giảm dần capacity, giới hạn 3)

SELECT country,
       SUM(capacity) AS total_capacity
FROM solar_farms
GROUP BY country
ORDER BY total_capacity DESC
LIMIT 3;
-- Problem: SQL1650 - Kể tên top 3 quốc gia có công suất điện mặt trời lớn nhất (MW).html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
