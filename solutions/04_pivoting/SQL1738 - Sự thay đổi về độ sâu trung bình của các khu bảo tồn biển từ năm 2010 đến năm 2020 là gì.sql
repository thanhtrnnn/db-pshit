-- Tables: marine_protected_areas
-- Technique: Conditional Aggregation (dialect: Mysql)

SELECT
    AVG(CASE WHEN year = 2020 THEN avg_depth ELSE NULL END) - AVG(CASE WHEN year = 2010 THEN avg_depth ELSE NULL END) AS depth_change
FROM
    marine_protected_areas
WHERE
    year IN (2010, 2020);