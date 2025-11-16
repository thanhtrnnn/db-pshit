-- Tables: suppliers
-- Technique: Filtering (dialect: Mysql)

SELECT
    supplier_name
FROM
    suppliers
WHERE
    energy_type = 'Both';