 -- Tables: SalesData
 -- Technique: Aggregate function (dialect: MySQL)
 SELECT
  SUM(QuantitySold) AS total_quantity
 FROM
  SalesData
 WHERE
  Gender = 'Men'
  AND Size = 32
  AND SaleDate >= '2025-01-01'
  AND SaleDate <= '2025-03-31';