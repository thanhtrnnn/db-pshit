-- Tables: wind_farms, solar_farms
-- Technique: set_operations (dialect: Sql Server)

SELECT COUNT(id) AS total_farms FROM wind_farms
UNION ALL
SELECT COUNT(id) AS total_farms FROM solar_farms;