 -- Tables: Customer, SaleOrder, VipCustomer
 -- Technique: INSERT INTO ... SELECT (dialect: Mysql)

INSERT INTO VipCustomer (CustID, CustomerName, City, TotalSpent2024)
SELECT
  c.CustID,
  c.CustomerName,
  c.City,
  SUM(so.TotalAmount) AS TotalSpent2024
FROM
  Customer AS c
JOIN
  SaleOrder AS so
  ON c.CustID = so.CustID
WHERE
  YEAR(so.OrderDate) = 2024
GROUP BY
  c.CustID,
  c.CustomerName,
  c.City
HAVING
  SUM(so.TotalAmount) >= 2000;
