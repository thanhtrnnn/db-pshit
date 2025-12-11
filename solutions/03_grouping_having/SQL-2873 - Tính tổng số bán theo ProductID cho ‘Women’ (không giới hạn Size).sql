 -- Tables: SalesData
 -- Technique: Aggregation, Filtering, Grouping (dialect: Mysql)

 SELECT
  ProductID,
  SUM(QuantitySold) AS total_quantity
 FROM
  SalesData
 WHERE
  YEAR(SaleDate) = 2025
  AND Gender = 'Women'
 GROUP BY
  ProductID
 HAVING
  total_quantity >= 10
 ORDER BY
  total_quantity DESC;