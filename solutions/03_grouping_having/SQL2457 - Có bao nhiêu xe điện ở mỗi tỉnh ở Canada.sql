-- Tables: canada_vehicles
-- Technique: Group By (dialect: Mysql)
SELECT
    province,
    'Electric' AS vehicle_type,
    SUM(quantity) AS total_electric_vehicles
FROM
    canada_vehicles
WHERE
    vehicle_type = 'Electric'
GROUP BY
    province;