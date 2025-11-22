 -- Tables: project, engineer
 -- Technique: JOIN (dialect: Mysql)
 
 SELECT
  p.name
 FROM
  project AS p
  JOIN engineer AS e ON p.id = e.project_id
 WHERE
  p.start_date < '2019-01-01'
  AND e.name = 'Alex'
  AND e.role = 'Lead';