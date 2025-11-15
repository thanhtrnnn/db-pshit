 -- Tables: Facilities
 -- Technique: GROUP BY (dialect: Mysql)
 
 SELECT
  State,
  Type,
  SUM(Count) AS TotalFacilities
 FROM
  Facilities
 WHERE
  Year = 2022
  AND Type IN ('Public School', 'Public Hospital')
 GROUP BY
  State,
  Type
 ORDER BY
  State,
  Type;