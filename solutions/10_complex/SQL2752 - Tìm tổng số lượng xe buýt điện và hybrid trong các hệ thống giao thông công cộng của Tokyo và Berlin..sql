-- Tables: tokyo_buses, berlin_buses
-- Technique: UNION ALL, Aggregate Function (dialect: Mysql)

SELECT
    SUM(quantity)
FROM
(
    SELECT quantity FROM tokyo_buses WHERE type IN ('electric', 'hybrid')
    UNION ALL
    SELECT quantity FROM berlin_buses WHERE type IN ('electric', 'hybrid')
) AS combined_buses;