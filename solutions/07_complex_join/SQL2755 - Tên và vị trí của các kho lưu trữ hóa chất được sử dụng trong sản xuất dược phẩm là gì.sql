-- Tables: warehouses, chemicals, inventory
-- Technique: JOIN (dialect: Mysql)

SELECT DISTINCT
    w.name,
    w.location
FROM
    warehouses AS w
JOIN
    inventory AS i ON w.id = i.warehouse_id
JOIN
    chemicals AS c ON i.chemical_id = c.id
WHERE
    c.type = 'Pharma';