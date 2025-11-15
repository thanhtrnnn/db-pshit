-- Tables: region_waste
-- Technique: Group By, Order By, Limit (dialect: MySQL)

SELECT
    region,
    SUM(waste_amount) AS total_waste
FROM
    region_waste
WHERE
    year = 2021
GROUP BY
    region
ORDER BY
    total_waste DESC
LIMIT 3;