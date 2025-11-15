-- Tables: Strains, Inventory, Sales
-- Technique: JOIN, GROUP BY, SUM, WHERE (dialect: Mysql)

SELECT
    s.name AS strain_name,
    SUM(sl.quantity) AS total_quantity_sold
FROM
    Strains AS s
JOIN
    Inventory AS i ON s.id = i.strain_id
JOIN
    Sales AS sl ON i.id = sl.inventory_id
WHERE
    YEAR(sl.sale_date) = 2022 AND QUARTER(sl.sale_date) = 1
GROUP BY
    s.name
ORDER BY
    s.name;