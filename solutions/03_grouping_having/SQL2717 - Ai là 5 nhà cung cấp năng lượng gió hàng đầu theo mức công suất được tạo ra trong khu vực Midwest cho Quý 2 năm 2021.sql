-- Tables: region, provider, renewable_source, power_generation
-- Technique: JOIN, GROUP BY, ORDER BY, LIMIT (dialect: Mysql)
SELECT
  p.name AS provider_name,
  SUM(pg.power_generated) AS total_power_generated
FROM power_generation AS pg
JOIN renewable_source AS rs
  ON pg.source_id = rs.id
JOIN provider AS p
  ON rs.provider_id = p.id
JOIN region AS r
  ON p.region_id = r.id
WHERE
  r.name = 'Midwest' AND rs.name = 'Wind' AND pg.date BETWEEN '2021-04-01' AND '2021-06-30'
GROUP BY
  p.name
ORDER BY
  total_power_generated DESC
LIMIT 3;