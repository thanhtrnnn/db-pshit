-- Tables: fans
-- Technique: Group By, Order By, Limit (dialect: MySQL)

SELECT
  country,
  COUNT(fan_id) AS fan_count
FROM fans
GROUP BY
  country
ORDER BY
  fan_count DESC
LIMIT 1;