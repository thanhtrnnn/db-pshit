-- Tables: Carrier, Truck, Shipment
-- Technique: JOIN (dialect: Mysql)
SELECT
    c.country,
    c.name,
    SUM(s.weight) AS total_weight
FROM
    Carrier AS c
JOIN
    Truck AS t ON c.id = t.carrier_id
JOIN
    Shipment AS s ON t.id = s.truck_id
GROUP BY
    c.country,
    c.name
ORDER BY
    c.country, c.name;