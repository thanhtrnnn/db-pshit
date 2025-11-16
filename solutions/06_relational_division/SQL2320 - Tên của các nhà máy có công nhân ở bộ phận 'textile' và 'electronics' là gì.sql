 -- Tables: factories, departments, workers
 -- Technique: Joins, Group By, Having (dialect: Mysql)
 SELECT
  f.factory_name
 FROM
  factories AS f
  JOIN workers AS w ON f.factory_id = w.factory_id
  JOIN departments AS d ON w.department_id = d.department_id
 WHERE
  d.department IN ('textile', 'electronics')
 GROUP BY
  f.factory_id,
  f.factory_name
 HAVING
  COUNT(DISTINCT d.department) = 2;