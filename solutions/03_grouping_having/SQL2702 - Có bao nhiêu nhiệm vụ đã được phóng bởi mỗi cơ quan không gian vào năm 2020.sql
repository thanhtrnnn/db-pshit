 -- Tables: missions
 -- Technique: Group By (dialect: Mysql)
 
 SELECT
  space_agency,
  COUNT(*) AS `COUNT(*)`
 FROM
  missions
 WHERE
  YEAR(launch_date) = 2020
 GROUP BY
  space_agency;