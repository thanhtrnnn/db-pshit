 -- Tables: CUSTOMER, SALEORDER, PAYMENT
 -- Technique: LEFT JOIN, GROUP BY, SUM, IFNULL (dialect: MySQL)
 SELECT
  c.CustomerName,
  IFNULL(SUM(paid_orders.Total), 0.00) AS PaidTotal
 FROM
  CUSTOMER AS c
 LEFT JOIN (
  SELECT
   so.CustID,
   so.Total
  FROM
   SALEORDER AS so
  INNER JOIN
   PAYMENT AS p ON so.OrderID = p.OrderID
  WHERE
   p.Status = 'PAID'
 ) AS paid_orders ON c.CustID = paid_orders.CustID
 GROUP BY
  c.CustomerName
 ORDER BY
  c.CustomerName ASC;