 -- Tables: broadband_subscribers
 -- Technique: Group By (dialect: Mysql)

 SELECT
  region,
  AVG(speed) AS avg_speed,
  COUNT(subscriber_id) AS total_subscribers
 FROM
  broadband_subscribers
 GROUP BY
  region;