--- Tables: ingredient, recipe
--- Technique: JOIN, Filtering, Aggregation (dialect: Mysql)

SELECT
    i.ingredient_name,
    COUNT(r.ingredient_id) AS use_count
FROM
    ingredient AS i
JOIN
    recipe AS r
ON
    i.ingredient_id = r.ingredient_id
WHERE
    YEAR(r.use_date) = YEAR(CURDATE() - INTERVAL 1 MONTH)
    AND MONTH(r.use_date) = MONTH(CURDATE() - INTERVAL 1 MONTH)
GROUP BY
    i.ingredient_name
ORDER BY
    i.ingredient_name;