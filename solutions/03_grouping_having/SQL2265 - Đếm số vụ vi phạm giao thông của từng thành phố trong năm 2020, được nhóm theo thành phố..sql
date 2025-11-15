-- Tables: traffic_violations
-- Technique: Group By (dialect: Mysql)

SELECT
  city,
  COUNT(*) AS `COUNT(*)`
FROM traffic_violations
WHERE
  year = 2020
GROUP BY
  city;