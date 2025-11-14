 -- Tables: projects
 -- Technique: Group By, Having (dialect: Mysql)

 SELECT
  volunteer_id
 FROM
  projects
 WHERE
  category IN ('Education', 'Environment')
 GROUP BY
  volunteer_id
 HAVING
  SUM(CASE WHEN category = 'Education' THEN 1 ELSE 0 END) > 0
  AND SUM(CASE WHEN category = 'Environment' THEN 1 ELSE 0 END) > 0;