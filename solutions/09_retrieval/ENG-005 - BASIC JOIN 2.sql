 -- Tables: Customer, SaleOrder
 -- Technique: INNER JOIN (dialect: Mysql)
 
 SELECT
  so.OrderID,
  c.CustomerName,
  c.City,
  so.OrderDate,
  so.TotalAmount
 FROM
  Customer AS c
  INNER JOIN SaleOrder AS so ON c.CustID = so.CustID
 WHERE
  c.City IN ('London', 'Paris')
  AND so.TotalAmount > 200;