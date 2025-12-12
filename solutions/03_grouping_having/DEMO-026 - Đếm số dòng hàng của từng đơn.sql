 -- Tables: Customer, SaleOrder, OrderItem
 -- Technique: JOIN, GROUP BY, HAVING (dialect: MySQL)
 
 SELECT
  so.OrderID,
  c.CustomerName,
  COUNT(oi.PID) AS TotalLines
 FROM
  SaleOrder AS so
  JOIN Customer AS c ON so.CustID = c.CustID
  JOIN OrderItem AS oi ON so.OrderID = oi.OrderID
 GROUP BY
  so.OrderID,
  c.CustomerName
 HAVING
  COUNT(oi.PID) >= 2
 ORDER BY
  so.OrderID;

-- subquery version
Select s.OrderID, c.CustomerName, ot.TotalLines
From Customer c
Join SaleOrder s on c.CustID = s.CustID
Join (
    Select OrderID, count(*) as TotalLines
    From OrderItem
    Group by OrderID
    Having count(*) >= 2
) ot on s.OrderID = ot.OrderID
Order by s.OrderID;