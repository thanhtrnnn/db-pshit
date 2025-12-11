-- Tables: vessels, voyages
-- Technique: JOIN (dialect: mysql)

SELECT
  v.name,
  COUNT(DISTINCT
    vy.region
  ) AS distinct_regions,
  SUM(vy.cargo_weight) AS total_cargo
FROM vessels AS v
JOIN voyages AS vy
  ON v.id = vy.vessel_id
GROUP BY
  v.id,
  v.name
HAVING
  COUNT(DISTINCT
    vy.region
  ) >= 2 AND SUM(vy.cargo_weight) > 0
ORDER BY
  distinct_regions DESC,
  total_cargo DESC,
  v.name;