-- Tables: time, sales, products
-- Technique: JOIN, Date Functions, Aggregation, LIMIT (dialect: mysql)

SELECT
    p.product_name,
    SUM(s.quantity) AS total_qty
FROM
    products AS p
JOIN
    sales AS s ON p.product_id = s.product_id
JOIN
    time AS t ON s.time_id = t.time_id
WHERE
    t.sale_date >= DATE_SUB((SELECT MAX(sale_date) FROM time), INTERVAL 30 DAY)
GROUP BY
    p.product_name
ORDER BY
    total_qty DESC
LIMIT 3;