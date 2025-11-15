-- Tables: Restaurants, Supplies
-- Technique: JOIN, GROUP BY, HAVING (dialect: Mysql)
SELECT
    S.supplier_name
FROM
    Supplies AS S
JOIN
    Restaurants AS R ON S.restaurant_id = R.restaurant_id
WHERE
    R.location IN ('California', 'New York')
GROUP BY
    S.supplier_name
HAVING
    COUNT(DISTINCT R.location) = 2;