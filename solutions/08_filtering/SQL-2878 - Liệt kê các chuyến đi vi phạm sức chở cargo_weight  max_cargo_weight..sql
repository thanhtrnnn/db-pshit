-- Tables: vessels, voyages
-- Technique: JOIN (dialect: Mysql)
SELECT
  v.name AS vessel_name,
  vo.id AS voyage_id,
  vo.cargo_weight,
  v.max_cargo_weight
FROM voyages AS vo
JOIN vessels AS v
  ON vo.vessel_id = v.id
WHERE
  vo.cargo_weight > v.max_cargo_weight
ORDER BY
  vo.id;