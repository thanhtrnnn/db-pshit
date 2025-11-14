 -- Tables: factories, roles, workers
 -- Technique: JOIN, GROUP BY (dialect: Mysql)

 SELECT
  f.factory_name,
  AVG(w.salary) AS average_junior_salary
 FROM
  workers AS w
 JOIN
  roles AS r
  ON w.role_id = r.role_id
 JOIN
  factories AS f
  ON w.factory_id = f.factory_id
 WHERE
  r.role_name = 'junior'
 GROUP BY
  f.factory_id, f.factory_name;