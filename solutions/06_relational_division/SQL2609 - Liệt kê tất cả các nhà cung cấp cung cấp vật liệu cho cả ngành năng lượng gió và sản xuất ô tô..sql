-- Tables: suppliers
-- Technique: Group By and Having (dialect: Mysql)

SELECT
    name
FROM
    suppliers
WHERE
    industry IN ('Wind Energy', 'Automotive')
GROUP BY
    name
HAVING
    COUNT(DISTINCT industry) = 2;