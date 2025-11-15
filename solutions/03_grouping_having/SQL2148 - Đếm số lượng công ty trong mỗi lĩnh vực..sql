-- Tables: companies
-- Technique: Group By (dialect: Mysql)

SELECT
  sector,
  COUNT(id) AS `COUNT(*)`
FROM
  companies
GROUP BY
  sector
ORDER BY
  `COUNT(*)` DESC;