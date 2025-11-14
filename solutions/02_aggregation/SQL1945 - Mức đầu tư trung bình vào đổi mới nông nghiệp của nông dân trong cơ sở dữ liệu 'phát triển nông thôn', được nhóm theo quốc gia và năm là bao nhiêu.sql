-- Tables: farmers
-- Technique: GROUP BY (dialect: MySQL)

SELECT
  country,
  year,
  AVG(innovation_investment) AS average_investment
FROM farmers
GROUP BY
  country,
  year;