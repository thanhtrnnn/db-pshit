 -- Tables: Customers, Orders, EthicalProducts
 -- Technique: Joins, Subquery, Aggregation (dialect: Mysql)
 
 SELECT
  c.CustomerName,
  SUM(o.OrderValue) AS TotalSpending
 FROM
  Customers AS c
 JOIN
  Orders AS o ON c.CustomerID = o.CustomerID
 WHERE
  o.OrderID IN (
  SELECT DISTINCT
  OrderID
  FROM
  EthicalProducts
  )
 GROUP BY
  c.CustomerID,
  c.CustomerName
 ORDER BY
  TotalSpending DESC
 LIMIT 3;