-- Tables: SALEORDER
-- Technique: Group By, Aggregate Function (dialect: Mysql)

SELECT
    CustID,
    SUM(Total) AS TotalRevenue
FROM
    SALEORDER
GROUP BY
    CustID
ORDER BY
    CustID ASC;