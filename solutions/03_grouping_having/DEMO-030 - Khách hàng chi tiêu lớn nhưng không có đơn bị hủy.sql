 -- Tables: Customer, SaleOrder
 -- Technique: JOIN, GROUP BY, HAVING (dialect: Mysql)
SELECT
  c.CustID,
  c.CustomerName,
  SUM(so.TotalAmount) AS TotalSpent
FROM
  Customer AS c
JOIN SaleOrder AS so ON c.CustID = so.CustID
WHERE
  YEAR(so.OrderDate) = 2024
GROUP BY
  c.CustID,
  c.CustomerName
HAVING
  SUM(so.TotalAmount) >= 1000
  AND SUM(CASE WHEN so.Status = 'CANCELLED' THEN 1 ELSE 0 END) = 0;