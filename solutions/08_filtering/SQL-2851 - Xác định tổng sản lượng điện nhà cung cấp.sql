SELECT
  p.name AS provider_name,
  SUM(pg.power_generated) AS total_power_generated
FROM provider AS p
JOIN region AS r
  ON p.region_id = r.id
JOIN renewable_source AS rs
  ON p.id = rs.provider_id
JOIN power_generation AS pg
  ON rs.id = pg.source_id
WHERE
  r.name LIKE 'S%'
  AND rs.name = 'Wind'
  AND pg.date BETWEEN '2021-04-01' AND '2021-06-30'
GROUP BY
  p.name
ORDER BY
  total_power_generated DESC
LIMIT 3;