-- Tables: astronauts
-- Technique: Group By, Order By, Limit (dialect: Mysql)
SELECT
  country,
  COUNT(*) AS `COUNT(*)`
FROM
  astronauts
WHERE
  flight_experience LIKE '%Airbus A320%'
GROUP BY
  country
ORDER BY
  COUNT(*) DESC
LIMIT 1;