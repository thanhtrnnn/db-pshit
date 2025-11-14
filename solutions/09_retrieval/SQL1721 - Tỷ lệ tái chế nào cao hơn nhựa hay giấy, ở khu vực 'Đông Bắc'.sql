 -- Tables: recycling_rates
 -- Technique: Filtering, Ordering, Limiting (dialect: Mysql)

 SELECT
  material
 FROM
  recycling_rates
 WHERE
  region = 'Đông Bắc' AND material IN ('plastic', 'paper')
 ORDER BY
  recycling_rate DESC
 LIMIT 1;