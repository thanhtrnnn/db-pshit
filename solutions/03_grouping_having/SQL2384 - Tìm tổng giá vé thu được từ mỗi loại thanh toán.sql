 -- Tables: fare_collection
 -- Technique: Group By, Aggregate Function (dialect: MySQL)
 
 SELECT
  payment_type,
  SUM(fare) AS total_fare
 FROM
  fare_collection
 GROUP BY
  payment_type
 ORDER BY
  payment_type;