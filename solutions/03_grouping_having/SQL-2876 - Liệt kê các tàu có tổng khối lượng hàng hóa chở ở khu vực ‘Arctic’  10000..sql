-- Tables: vessels, voyages
-- Technique: JOIN, GROUP BY, HAVING, ORDER BY (dialect: MySQL)

SELECT
  v.name,
  SUM(voy.cargo_weight) AS total_cargo_arctic
FROM vessels AS v
JOIN voyages AS voy
  ON v.id = voy.vessel_id
WHERE
  voy.region = 'Arctic'
GROUP BY
  v.name
HAVING
  SUM(voy.cargo_weight) > 10000
ORDER BY
  total_cargo_arctic DESC;