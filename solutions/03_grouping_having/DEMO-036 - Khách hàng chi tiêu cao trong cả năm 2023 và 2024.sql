SELECT
    c.CustID,
    c.CustomerName
FROM
    Customer AS c
JOIN
    SaleOrder AS so ON c.CustID = so.CustID
JOIN
    Payment AS p ON so.OrderID = p.OrderID
WHERE
    p.Status = 'PAID'
    AND YEAR(so.OrderDate) IN (2023, 2024)
GROUP BY
    c.CustID,
    c.CustomerName
HAVING
    SUM(p.Amount) >= 500;