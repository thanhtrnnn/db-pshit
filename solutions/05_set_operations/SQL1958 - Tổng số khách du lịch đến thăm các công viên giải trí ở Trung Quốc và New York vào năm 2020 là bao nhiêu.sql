-- Tables: china_theme, new_york_theme
-- Technique: UNION ALL, Aggregate (dialect: Mysql)
SELECT
  SUM(visitors) AS total_visitors
FROM
  (
    SELECT
      visitors
    FROM
      china_theme
    WHERE
      year = 2020
    UNION ALL
    SELECT
      visitors
    FROM
      new_york_theme
    WHERE
      year = 2020
  ) AS combined_visitors;