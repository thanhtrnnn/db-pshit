 -- Tables: Events
 -- Technique: Aggregation, Filtering, Ordering (dialect: MySQL)
 
 SELECT
  Country,
  COUNT(EventID) AS TotalEvents
 FROM
  Events
 WHERE
  YEAR(StartDate) = 2023
 GROUP BY
  Country
 ORDER BY
  TotalEvents DESC
 LIMIT 1;