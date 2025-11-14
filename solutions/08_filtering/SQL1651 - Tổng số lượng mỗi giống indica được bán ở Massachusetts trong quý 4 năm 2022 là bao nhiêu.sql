-- Tables: Cultivars, Inventory, Sales
-- Technique: Joins, Filtering, Aggregation (dialect: Sql Server)

SELECT
    C.name AS CultivarName,
    SUM(S.quantity) AS TotalQuantitySold
FROM
    Cultivars AS C
JOIN
    Inventory AS I ON C.id = I.cultivar_id
JOIN
    Sales AS S ON I.id = S.inventory_id
WHERE
    C.type = 'Indica'
    AND YEAR(S.sale_date) = 2022
    AND MONTH(S.sale_date) BETWEEN 10 AND 12
GROUP BY
    C.name;