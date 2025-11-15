 -- Tables: financial_wellbeing
 -- Technique: Group By (dialect: Mysql)

 SELECT
  region,
  AVG(score) AS average_score
 FROM
  financial_wellbeing
 GROUP BY
  region;