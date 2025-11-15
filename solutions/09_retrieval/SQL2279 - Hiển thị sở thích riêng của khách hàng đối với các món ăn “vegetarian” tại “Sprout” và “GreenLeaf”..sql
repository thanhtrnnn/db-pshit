--- Tables: Sprout, GreenLeaf
--- Technique: Inner Join (dialect: Mysql)

SELECT
    s.customer_id
FROM
    Sprout AS s
INNER JOIN
    GreenLeaf AS g ON s.customer_id = g.customer_id
WHERE
    s.dish_type = 'vegetarian' AND g.dish_type = 'vegetarian';