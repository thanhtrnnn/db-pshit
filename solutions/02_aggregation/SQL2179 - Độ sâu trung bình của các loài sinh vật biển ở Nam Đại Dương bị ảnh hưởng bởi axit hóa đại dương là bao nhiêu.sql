-- Tables: marine_species
-- Technique: Aggregation (dialect: Mysql)
SELECT AVG(min_depth) AS avg_depth
FROM marine_species
WHERE affected_by_acidification = TRUE AND ocean = 'Southern Ocean';