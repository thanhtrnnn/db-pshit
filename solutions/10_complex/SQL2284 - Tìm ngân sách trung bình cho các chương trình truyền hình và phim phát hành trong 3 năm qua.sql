-- Tables: movies, tv_shows
-- Technique: UNION ALL (dialect: Mysql)
SELECT
  AVG(budget) AS `AVG(budget)`
FROM (
  SELECT
    budget,
    release_year
  FROM
    movies
  UNION ALL
  SELECT
    budget,
    release_year
  FROM
    tv_shows
) AS combined_media
WHERE
  release_year >= YEAR(CURDATE()) - 2;