-- Tables: Customer, SaleOrder
-- Technique: JOIN (dialect: mysql)

SELECT
  so.OrderID,
  c.CustomerName,
  so.OrderDate,
  so.TotalAmount
FROM SaleOrder AS so
JOIN Customer AS c
  ON so.CustID = c.CustID
WHERE
  c.City = 'Ha Noi' AND so.TotalAmount > 500
ORDER BY
  so.OrderID;