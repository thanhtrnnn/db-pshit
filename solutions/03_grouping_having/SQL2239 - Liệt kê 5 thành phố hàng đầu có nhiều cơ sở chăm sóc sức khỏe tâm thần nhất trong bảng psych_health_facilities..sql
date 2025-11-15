-- Tables: mental_health_facilities
-- Technique: Group By, Order By, Limit (dialect: Mysql)

SELECT
  city,
  COUNT(facility_id) AS facility_count
FROM mental_health_facilities
GROUP BY
  city
ORDER BY
  facility_count DESC
LIMIT 5;