 -- Tables: articles, users, user_likes
 -- Technique: JOIN, Aggregation (dialect: Mysql)

 SELECT
  AVG(u.age) AS average_age
 FROM users AS u
 JOIN user_likes AS ul
  ON u.id = ul.user_id
 JOIN articles AS a
  ON ul.article_id = a.id
 WHERE
  a.category = 'climate_change';