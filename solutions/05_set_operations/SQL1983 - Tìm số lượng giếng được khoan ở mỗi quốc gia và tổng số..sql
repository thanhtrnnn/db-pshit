-- Tables: wells
-- Technique: GROUP BY, UNION ALL (dialect: MySQL)
SELECT
    country,
    COUNT(well_id) AS num_wells
FROM
    wells
GROUP BY
    country

UNION ALL

SELECT
    'Total' AS country,
    COUNT(well_id) AS num_wells
FROM
    wells
ORDER BY
    CASE WHEN country = 'Total' THEN 1 ELSE 0 END, country;