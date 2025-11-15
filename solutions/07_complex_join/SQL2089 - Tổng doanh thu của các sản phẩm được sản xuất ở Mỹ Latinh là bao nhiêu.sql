-- Tables: factories, products_factories, sales
-- Technique: JOIN, WHERE, SUM (dialect: Mysql)
SELECT
    SUM(s.revenue)
FROM
    sales AS s
JOIN
    products_factories AS pf ON s.product_id = pf.product_id
JOIN
    factories AS f ON pf.factory_id = f.factory_id
WHERE
    f.location LIKE '%Latin America%';