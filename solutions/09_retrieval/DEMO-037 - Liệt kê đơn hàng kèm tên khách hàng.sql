SELECT
  so.OrderID,
  c.CustomerName,
  so.OrderDate,
  so.TotalAmount
FROM SaleOrder AS so
JOIN Customer AS c
  ON so.CustID = c.CustID
ORDER BY
  so.OrderID ASC;