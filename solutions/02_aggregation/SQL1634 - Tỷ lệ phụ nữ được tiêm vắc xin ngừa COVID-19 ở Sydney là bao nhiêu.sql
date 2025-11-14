--- Tables: Vaccinations
--- Technique: aggregation (dialect: Sql Server)

SELECT
    ROUND(
        CAST(SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) AS DECIMAL(10, 2)) * 100.0 /
        CAST(COUNT(*) AS DECIMAL(10, 2))
    , 2) AS "Female_Percentage_Sydney(%)"
FROM
    Vaccinations
WHERE
    City = 'Sydney';