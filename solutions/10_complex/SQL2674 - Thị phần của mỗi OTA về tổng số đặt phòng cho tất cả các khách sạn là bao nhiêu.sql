 -- Tables: ota_bookings
 -- Technique: Aggregate functions, Subquery (dialect: Mysql)
 SELECT
  ota_name,
  SUM(revenue) AS total_revenue,
  SUM(revenue) / ( SELECT SUM(revenue) FROM ota_bookings ) AS market_share
 FROM
  ota_bookings
 GROUP BY
  ota_name;