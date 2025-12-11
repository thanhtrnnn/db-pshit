-- Tables: union_status, construction_sectors, workplace_safety_incidents
-- Technique: JOIN, GROUP BY, FILTER (dialect: Mysql)
SELECT
  cs.sector_name,
  us.union_status,
  SUM(wsi.incidents) AS total_incidents
FROM workplace_safety_incidents AS wsi
JOIN construction_sectors AS cs
  ON wsi.sector_id = cs.sector_id
JOIN union_status AS us
  ON wsi.union_status_id = us.id
WHERE
  wsi.incident_year IN (2021, 2022)
GROUP BY
  cs.sector_name,
  us.union_status
ORDER BY
  cs.sector_name,
  us.union_status;