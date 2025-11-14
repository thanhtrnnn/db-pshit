 -- Tables: MilitaryBases
 -- Technique: Group By (dialect: Mysql)

 SELECT
  Country,
  COUNT(BaseID) AS TotalBases
 FROM
  MilitaryBases
 GROUP BY
  Country;