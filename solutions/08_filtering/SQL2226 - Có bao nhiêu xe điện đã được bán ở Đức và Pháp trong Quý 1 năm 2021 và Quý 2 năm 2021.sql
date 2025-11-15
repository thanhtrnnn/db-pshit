-- Tables: electric_vehicle_sales
-- Technique: Filtering and Aggregation (dialect: Mysql)

SELECT
  country,
  SUM(quantity)
FROM
  electric_vehicle_sales
WHERE
  country IN ('Germany', 'France')
  AND sale_quarter IN ('Q1 2021', 'Q2 2021')
GROUP BY
  country;