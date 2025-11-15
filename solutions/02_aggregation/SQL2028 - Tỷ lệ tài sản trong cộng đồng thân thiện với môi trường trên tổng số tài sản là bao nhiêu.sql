-- Tables: property_counts
-- Technique: Aggregate Functions (dialect: Mysql)
SELECT
    CAST(SUM(CASE WHEN community_type = 'eco-friendly' THEN count ELSE 0 END) AS DECIMAL(10, 4)) / SUM(count)
FROM
    property_counts;