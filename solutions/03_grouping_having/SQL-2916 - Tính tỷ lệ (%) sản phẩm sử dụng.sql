-- Tables: Products, ProductTransparency
-- Technique: Joins, Group By, Having, Aggregate Functions (dialect: MySQL)
SELECT
    p.country,
    ROUND(
        100.0 * SUM(pt.recycled_materials) / COUNT(p.product_id),
        2
    ) AS recycle_rate
FROM
    Products AS p
JOIN
    ProductTransparency AS pt
ON
    p.product_id = pt.product_id
GROUP BY
    p.country
HAVING
    COUNT(p.product_id) >= 2
ORDER BY
    recycle_rate DESC,
    p.country ASC;