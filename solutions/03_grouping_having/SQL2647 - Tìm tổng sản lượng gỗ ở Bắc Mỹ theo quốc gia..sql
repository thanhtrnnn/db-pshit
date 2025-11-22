-- Tables: timber_production
-- Technique: Group By (dialect: Mysql)

SELECT
  country,
  SUM(volume)
FROM
  timber_production
WHERE
  region = 'Bắc Mỹ'
GROUP BY
  country;