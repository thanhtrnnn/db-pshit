--- Tables: solar_farms
--- Technique: Aggregate, Order By, Top N (dialect: Sql Server)

SELECT TOP 3
    country,
    SUM(capacity) AS total_capacity
FROM
    solar_farms
GROUP BY
    country
ORDER BY
    total_capacity DESC;