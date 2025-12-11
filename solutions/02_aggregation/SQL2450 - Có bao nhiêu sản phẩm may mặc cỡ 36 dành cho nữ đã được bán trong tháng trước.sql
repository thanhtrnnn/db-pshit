-- Tables: SalesData
-- Technique: Filtering, Aggregation (dialect: Mysql)

SELECT
    SUM(QuantitySold) AS total_quantity
FROM
    SalesData
WHERE
    Gender = 'Women' AND Size = 36 AND YEAR(SaleDate) = 2025 AND MONTH(SaleDate) = 5;