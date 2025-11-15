-- Tables: MarineSpeciesObservations
-- Technique: Group By (dialect: Mysql)

SELECT
    year AS `Năm`,
    COUNT(*) AS `Tổng số lượng quan sát`
FROM
    MarineSpeciesObservations
WHERE
    location IN ('Pacific Ocean', 'Atlantic Ocean')
GROUP BY
    year
ORDER BY
    year;