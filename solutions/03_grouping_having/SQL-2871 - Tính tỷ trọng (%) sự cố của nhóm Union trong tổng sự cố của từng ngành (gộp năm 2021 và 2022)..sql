 -- Tables: union_status, construction_sectors, workplace_safety_incidents
 -- Technique: Joins, Conditional Aggregation, Group By, Having (dialect: Mysql)
 
 SELECT
  cs.sector_name,
  ROUND(100.0 *
   SUM(CASE WHEN us.union_status = 'Union' THEN wsi.incidents ELSE 0 END) /
   SUM(wsi.incidents)
  ) AS union_share_pct
 FROM
  workplace_safety_incidents wsi
 JOIN
  union_status us ON wsi.union_status_id = us.id
 JOIN
  construction_sectors cs ON wsi.sector_id = cs.sector_id
 WHERE
  wsi.incident_year IN (2021, 2022)
 GROUP BY
  cs.sector_name
 HAVING
  SUM(CASE WHEN us.union_status = 'Union' THEN wsi.incidents ELSE 0 END) > 0
  AND
  SUM(CASE WHEN us.union_status = 'Non-Union' THEN wsi.incidents ELSE 0 END) > 0
 ORDER BY
  union_share_pct DESC;