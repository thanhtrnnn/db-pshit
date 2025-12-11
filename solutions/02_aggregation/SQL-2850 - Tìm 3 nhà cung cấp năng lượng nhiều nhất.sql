-- Tables: provider, renewable_source, power_generation, region
-- Technique: JOIN, GROUP BY, SUM, ORDER BY, LIMIT (dialect: mysql)
SELECT
  p.name AS provider_name,
  SUM(pg.power_generated) AS total_power_generated
FROM provider AS p
JOIN renewable_source AS rs
  ON p.id = rs.provider_id
JOIN power_generation AS pg
  ON rs.id = pg.source_id
JOIN region AS r
  ON p.region_id = r.id
WHERE
  rs.name = 'Solar' AND r.name <> 'Midwest' AND (pg.date < '2021-04-01' OR pg.date > '2021-06-30')
GROUP BY
  p.name
ORDER BY
  total_power_generated DESC
LIMIT 3;