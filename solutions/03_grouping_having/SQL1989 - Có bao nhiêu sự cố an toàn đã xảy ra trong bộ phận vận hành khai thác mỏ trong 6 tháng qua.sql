 -- Tables: department, incident
 -- Technique: JOIN, Filtering, Aggregation (dialect: Mysql)
 SELECT
  d.id AS department_id,
  COUNT(i.id) AS incident_count
 FROM department AS d
 JOIN incident AS i
  ON d.id = i.department_id
 WHERE
  d.name = 'Mining Operations' AND i.date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
 GROUP BY
  d.id;
