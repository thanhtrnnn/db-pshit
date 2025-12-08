-- Tables: OnlineOrder, StoreOrder
-- Technique: UNION ALL (dialect: mysql)

SELECT
    City,
    SUM(Amount) AS TotalRevenue
FROM (
    SELECT
        City,
        Amount
    FROM
        OnlineOrder
    UNION ALL
    SELECT
        City,
        Amount
    FROM
        StoreOrder
) AS CombinedOrders
GROUP BY
    City
ORDER BY
    City;