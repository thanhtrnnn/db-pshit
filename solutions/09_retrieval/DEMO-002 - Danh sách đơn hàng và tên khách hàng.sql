 -- Tables: CUSTOMER, SALEORDER
-- Technique: JOIN (dialect: MySQL)

SELECT
    so.OrderID,
    c.CustomerName
FROM
    SALEORDER AS so
JOIN
    CUSTOMER AS c
ON
    so.CustID = c.CustID
ORDER BY
    so.OrderID ASC;