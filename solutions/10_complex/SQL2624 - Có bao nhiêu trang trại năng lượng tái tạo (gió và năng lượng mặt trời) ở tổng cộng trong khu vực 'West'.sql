-- Tables: wind_farms, solar_farms
-- Technique: UNION ALL, Subquery, Aggregate (dialect: MySQL)
SELECT (
    SELECT COUNT(id)
    FROM wind_farms
    WHERE region = 'West'
) + (
    SELECT COUNT(id)
    FROM solar_farms
    WHERE region = 'West'
) AS total_farms;