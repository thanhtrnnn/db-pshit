SELECT DISTINCT
    i.country
FROM
    ingredients AS i
JOIN
    products AS p
    ON i.product_id = p.product_id
WHERE
    p.product_name = 'Facial Oil';