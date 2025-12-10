 -- Tables: CUSTOMER, ORDER
-- Technique: LEFT JOIN (dialect: Mysql)
SELECT
  c.CustID,
  c.CustomerName
FROM CUSTOMER AS c
LEFT JOIN
  SALEORDER AS o
ON
  c.CustID = o.CustID
WHERE
  o.OrderID IS NULL
ORDER BY
  c.CustID ASC;