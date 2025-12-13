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
GROUP BY
    c.CustID,
    c.CustomerName
HAVING
    SUM(CASE WHEN YEAR(so.OrderDate) = 2023 THEN p.Amount ELSE 0 END) >= 500
    AND SUM(CASE WHEN YEAR(so.OrderDate) = 2024 THEN p.Amount ELSE 0 END) >= 500;