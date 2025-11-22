 -- Tables: mining_company, drilling_company
 -- Technique: UNION ALL, COUNT (dialect: Mysql)

 SELECT
  COUNT(*) AS `COUNT(*)`
 FROM
  (
  SELECT
   id
  FROM
   mining_company
  UNION ALL
  SELECT
   id
  FROM
   drilling_company
  ) AS all_employees;