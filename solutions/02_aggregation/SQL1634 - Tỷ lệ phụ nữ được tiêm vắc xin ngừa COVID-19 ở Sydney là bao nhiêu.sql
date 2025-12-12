--- Tables: Vaccinations
--- Technique: aggregation (dialect: Sql Server)

SELECT 
    ROUND(SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) 
    AS "Female_Percentage_Sydney(%)"
FROM Vaccinations
WHERE City = 'Sydney';