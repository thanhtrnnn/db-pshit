SELECT
  pr.name AS provider_name,
  COUNT(DISTINCT pg.date) AS days_active,
  SUM(pg.power_generated) AS total_power_generated
FROM provider AS pr
JOIN region AS r
  ON pr.region_id = r.id
JOIN renewable_source AS rs
  ON pr.id = rs.provider_id
JOIN power_generation AS pg
  ON rs.id = pg.source_id
WHERE
  r.name LIKE '%East%'
  AND rs.name = 'Solar'
  AND pg.date BETWEEN '2021-02-01' AND '2021-05-31'
GROUP BY
  pr.id,
  pr.name
ORDER BY
  days_active DESC,
  total_power_generated DESC
LIMIT 2;