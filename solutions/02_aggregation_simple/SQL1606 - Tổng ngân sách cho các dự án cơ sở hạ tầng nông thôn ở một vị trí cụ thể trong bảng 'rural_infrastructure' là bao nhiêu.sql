 -- Tables: rural_infrastructure
 -- Technique: aggregation_simple (dialect: Sql Server)

 SELECT
  SUM(budget) AS total_budget
 FROM
  rural_infrastructure
 WHERE
  location = 'Village A';