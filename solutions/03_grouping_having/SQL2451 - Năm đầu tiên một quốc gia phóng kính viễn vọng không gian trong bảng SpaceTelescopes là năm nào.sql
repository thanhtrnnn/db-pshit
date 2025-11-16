-- Tables: SpaceTelescopes
-- Technique: Group By (dialect: Mysql)
SELECT
  country,
  MIN(year) AS earliest_year
FROM
  SpaceTelescopes
GROUP BY
  country;