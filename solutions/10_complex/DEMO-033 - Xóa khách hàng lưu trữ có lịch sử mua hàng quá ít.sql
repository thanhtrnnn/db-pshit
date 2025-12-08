-- Tables: CustomerArchive, SaleOrder
-- Technique: DELETE with LEFT JOIN and NOT EXISTS (dialect: Mysql)
DELETE ca
FROM CustomerArchive ca
LEFT JOIN (
    SELECT CustID, SUM(TotalAmount) AS total_pre_2024
    FROM SaleOrder
    WHERE OrderDate < '2024-01-01'
    GROUP BY CustID
) AS s1 ON ca.CustID = s1.CustID
WHERE
    COALESCE(s1.total_pre_2024, 0) < 500
    AND NOT EXISTS (
        SELECT 1
        FROM SaleOrder s2
        WHERE s2.CustID = ca.CustID
          AND s2.OrderDate >= '2024-01-01'
    );