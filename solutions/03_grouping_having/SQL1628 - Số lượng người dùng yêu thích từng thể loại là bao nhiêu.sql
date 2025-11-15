--- Tables: users
--- Technique: aggregation (dialect: Sql Server)

SELECT
  favorite_genre,
  COUNT(id) AS genre_count
FROM users
GROUP BY
  favorite_genre
ORDER BY
  favorite_genre;