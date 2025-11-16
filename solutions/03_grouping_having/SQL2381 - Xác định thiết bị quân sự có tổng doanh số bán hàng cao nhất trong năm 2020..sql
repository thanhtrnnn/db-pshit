-- Tables: Sales, Equipment
-- Technique: JOIN, Aggregate (dialect: Mysql)
SELECT
    e.Equipment_Name,
    SUM(s.Quantity * e.Unit_Price) AS TotalSales
FROM
    Sales AS s
JOIN
    Equipment AS e ON s.Equipment_ID = e.Equipment_ID
WHERE
    YEAR(s.Sale_Date) = 2020
GROUP BY
    e.Equipment_ID, e.Equipment_Name
ORDER BY
    TotalSales DESC
LIMIT 1;