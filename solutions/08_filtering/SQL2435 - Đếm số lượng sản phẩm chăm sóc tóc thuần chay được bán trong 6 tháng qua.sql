--- Tables: sales, products, time
--- Technique: Joins, Aggregation (dialect: Mysql)

SELECT
    SUM(s.quantity) AS num_products
FROM
    sales AS s
JOIN
    products AS p ON s.product_id = p.product_id
JOIN
    time AS t ON s.time_id = t.time_id
WHERE
    p.category = 'Hair Care'
    AND p.vegan = TRUE
    AND t.sale_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);