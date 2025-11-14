-- Tables: initiatives
-- Technique: GROUP BY (dialect: MySQL)

SELECT
  region,
  COUNT(id) AS count
FROM
  initiatives
WHERE
  accessibility_rating > 6
GROUP BY
  region
ORDER BY
  region;