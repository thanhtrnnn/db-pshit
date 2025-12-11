-- Tables: vessels, voyages
-- Technique: JOIN (dialect: MySQL)

SELECT DISTINCT
  v.name
FROM vessels AS v
JOIN voyages AS vo
  ON v.id = vo.vessel_id
WHERE
  vo.region = 'Arctic' AND vo.cargo_weight > 5000;