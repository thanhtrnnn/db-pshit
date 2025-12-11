-- Tables: SalesData
-- Technique: Filtering, Aggregate Function (dialect: MySQL)
SELECT
    AVG(QuantitySold) AS avg_quantity
FROM
    SalesData
WHERE
    Size = 36
    AND MONTH(SaleDate) = 5
    AND YEAR(SaleDate) = 2025;