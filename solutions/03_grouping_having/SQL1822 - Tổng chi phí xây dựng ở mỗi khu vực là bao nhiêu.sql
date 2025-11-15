 -- Tables: construction_spending
 -- Technique: Group By (dialect: MySQL)
 
 SELECT
  region,
  SUM(amount) AS total_spending
 FROM
  construction_spending
 GROUP BY
  region;