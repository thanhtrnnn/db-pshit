 -- Tables: movies, tv_shows
 -- Technique: UNION ALL (dialect: Mysql)
 
 SELECT MIN(rating) AS `MIN(rating)`
 FROM movies
 WHERE country = 'Brazil'
 UNION ALL
 SELECT MIN(rating) AS `MIN(rating)`
 FROM tv_shows
 WHERE country = 'Brazil';