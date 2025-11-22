 -- Tables: mobile_subscribers, broadband_subscribers
 -- Technique: Scalar Subqueries (dialect: Mysql)

 SELECT
  IFNULL(
   (SELECT COUNT(CASE WHEN technology = '4G' THEN 1 ELSE NULL END) * 100.0 / COUNT(*) FROM mobile_subscribers),
   0.00
  ) AS mobile_4g_percentage,
  IFNULL(
   (SELECT COUNT(CASE WHEN technology = '4G' THEN 1 ELSE NULL END) * 100.0 / COUNT(*) FROM broadband_subscribers),
   0.00
  ) AS broadband_4g_percentage;