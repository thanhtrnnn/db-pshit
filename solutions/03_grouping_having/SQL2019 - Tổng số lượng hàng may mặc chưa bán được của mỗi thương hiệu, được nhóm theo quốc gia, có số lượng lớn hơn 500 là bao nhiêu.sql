 -- Tables: Countries, Brands, Inventory
 -- Technique: JOIN, GROUP BY, HAVING (dialect: Mysql)

SELECT
    c.country,
    b.brand,
    SUM(i.quantity) AS total_unsold_quantity
FROM
    Inventory AS i
JOIN
    Countries AS c
ON
    i.country_id = c.id
JOIN
    Brands AS b
ON
    i.brand_id = b.id
GROUP BY
    c.country,
    b.brand
HAVING
    SUM(i.quantity) > 500;