-- Tables: arctic_weather
-- Technique: Grouping, Filtering (dialect: MySQL)
SELECT
    MONTH(date) AS month,
    AVG(temperature) AS `AVG(temperature)`
FROM
    arctic_weather
WHERE
    YEAR(date) = 2020
GROUP BY
    MONTH(date)
ORDER BY
    month;