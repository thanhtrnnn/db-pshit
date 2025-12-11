 -- Tables: mobile_subscribers, broadband_subscribers
 -- Technique: UNION ALL, GROUP BY, ORDER BY, LIMIT (dialect: Mysql)

 SELECT
  name,
  SUM(subscription_fee) AS total_fee
 FROM
  (
  SELECT
   name,
   subscription_fee
  FROM
   mobile_subscribers
  WHERE
   date BETWEEN '2025-01-01' AND '2025-03-31'

  UNION ALL

  SELECT
   name,
   subscription_fee
  FROM
   broadband_subscribers
  WHERE
   date BETWEEN '2025-01-01' AND '2025-03-31'
  ) AS all_subscribers
 GROUP BY
  name
 ORDER BY
  total_fee DESC
 LIMIT 3;