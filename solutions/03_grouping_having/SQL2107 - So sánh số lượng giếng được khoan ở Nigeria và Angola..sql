-- Tables: wells
-- Technique: Group By, Filtering (dialect: Mysql)

SELECT
    country,
    COUNT(well_id) AS num_wells
FROM
    wells
WHERE
    country IN ('Nigeria', 'Angola')
GROUP BY
    country
ORDER BY
    country;