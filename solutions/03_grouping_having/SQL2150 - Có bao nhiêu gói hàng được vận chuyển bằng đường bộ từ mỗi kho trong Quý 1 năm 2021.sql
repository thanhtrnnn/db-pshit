-- Tables: packages, warehouses
-- Technique: JOIN, WHERE, GROUP BY (dialect: Mysql)
SELECT
    w.name AS warehouse_name,
    COUNT(p.id) AS number_of_packages
FROM
    packages AS p
JOIN
    warehouses AS w
    ON p.warehouse = w.id
WHERE
    p.shipment_type = 'Road'
    AND p.quarter = 1
GROUP BY
    w.name
ORDER BY
    w.name;