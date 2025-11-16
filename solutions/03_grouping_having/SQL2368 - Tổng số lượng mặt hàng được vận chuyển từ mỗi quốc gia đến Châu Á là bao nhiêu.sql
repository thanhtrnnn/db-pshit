-- Tables: Shipment
-- Technique: Group By (dialect: Mysql)
SELECT
    source_country,
    SUM(quantity) AS total_quantity_to_asia
FROM
    Shipment
WHERE
    destination_continent = 'Asia'
GROUP BY
    source_country
ORDER BY
    source_country;