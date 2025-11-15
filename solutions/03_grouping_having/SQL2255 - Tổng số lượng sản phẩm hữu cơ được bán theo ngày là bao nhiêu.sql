-- Tables: sales
-- Technique: Group By (dialect: MySQL)

SELECT
    date,
    SUM(quantity) AS "SUM(quantity)"
FROM
    sales
WHERE
    organic = TRUE
GROUP BY
    date
ORDER BY
    date;