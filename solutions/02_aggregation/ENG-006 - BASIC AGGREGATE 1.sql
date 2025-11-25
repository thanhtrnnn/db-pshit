-- Tables: SaleOrder
-- Technique: Basic Aggregate (dialect: Mysql)

SELECT
    CustID,
    COUNT(OrderID) AS OrderCount,
    SUM(TotalAmount) AS TotalSpent
FROM
    SaleOrder
GROUP BY
    CustID
ORDER BY
    CustID ASC;