 -- Tables: Countries, Veterans, Unemployment
 -- Technique: Joins, Group By, Order By, Limit (dialect: MySQL)

 SELECT
  c.Name,
  AVG(u.Rate) AS AvgRate
 FROM
  Countries AS c
 JOIN
  Veterans AS v
  ON c.CountryID = v.CountryID
 JOIN
  Unemployment AS u
  ON v.VeteranID = u.VeteranID
 GROUP BY
  c.CountryID,
  c.Name
 ORDER BY
  AvgRate DESC
 LIMIT 3;