-- Tables: CustomerArchive, SaleOrder
-- Technique: DELETE with LEFT JOIN and NOT EXISTS (dialect: Mysql)
DELETE ca 
FROM CustomerArchive ca
LEFT JOIN (
    SELECT CustID, SUM(TotalAmount) AS SpentBefore2024
    FROM SaleOrder
    WHERE OrderDate < '2024-01-01'
    GROUP BY CustID
) AS c1 ON ca.CustID = c1.CustID
WHERE
    COALESCE(c1.SpentBefore2024, 0) < 500
    AND ca.CustID NOT IN (
        SELECT DISTINCT CustID
        FROM SaleOrder
        WHERE OrderDate >= '2024-01-01'
    );

-- subquery
DELETE FROM CustomerArchive
WHERE CustID IN (
    SELECT CustID
    FROM SaleOrder
    GROUP BY CustID
    HAVING 
        SUM(CASE WHEN YEAR(OrderDate) < 2024 THEN TotalAmount ELSE 0 END) < 500
        AND 
        SUM(CASE WHEN YEAR(OrderDate) >= 2024 THEN 1 ELSE 0 END) = 0
) OR CustID NOT IN (
    SELECT DISTINCT CustID FROM SaleOrder
);