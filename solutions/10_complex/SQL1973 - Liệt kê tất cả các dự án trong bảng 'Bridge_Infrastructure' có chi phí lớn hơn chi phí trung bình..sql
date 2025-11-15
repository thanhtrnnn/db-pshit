 -- Tables: Bridge_Infrastructure
 -- Technique: Subquery (dialect: Mysql)

 SELECT
  project_name,
  location,
  cost
 FROM
  Bridge_Infrastructure
 WHERE
  cost > (
  SELECT
   AVG(cost)
  FROM
   Bridge_Infrastructure
  );