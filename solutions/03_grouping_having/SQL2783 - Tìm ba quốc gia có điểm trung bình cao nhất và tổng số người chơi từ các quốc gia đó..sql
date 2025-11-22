-- Tables: Players
-- Technique: Group By, Order By, Limit (dialect: Mysql)

SELECT
  Country,
  AVG(AverageScore) AS AvgScore,
  COUNT(PlayerID) AS TotalPlayers
FROM Players
GROUP BY
  Country
ORDER BY
  AvgScore DESC
LIMIT 3;