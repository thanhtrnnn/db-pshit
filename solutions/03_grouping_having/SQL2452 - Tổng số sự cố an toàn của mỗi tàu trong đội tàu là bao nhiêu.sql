-- Tables: safety_incidents
-- Technique: Group By (dialect: MySQL)

SELECT
  vessel_id,
  COUNT(*) AS `COUNT(*)`
FROM safety_incidents
GROUP BY
  vessel_id;