-- Tables: Customer, SaleOrder
-- Technique: JOIN, GROUP BY, HAVING (dialect: MySQL)
SELECT
    c.CustID,
    c.CustomerName,
    SUM(s.TotalAmount) AS TotalSpent
FROM
    Customer AS c
JOIN
    SaleOrder AS s
    ON c.CustID = s.CustID
GROUP BY
    c.CustID,
    c.CustomerName
HAVING
    SUM(s.TotalAmount) >= 1000
    AND MAX(CASE WHEN YEAR(s.OrderDate) = 2024 AND s.TotalAmount >= 500 THEN 1 ELSE 0 END) = 1
ORDER BY
    c.CustID;