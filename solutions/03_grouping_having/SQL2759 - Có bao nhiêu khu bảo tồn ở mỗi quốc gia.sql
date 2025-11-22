-- Tables: countries, protected_areas
-- Technique: JOIN, GROUP BY (dialect: Mysql)
SELECT
    c.country_name,
    COUNT(pa.area_id) AS total_areas
FROM
    countries AS c
LEFT JOIN
    protected_areas AS pa ON c.country_id = pa.country_id
GROUP BY
    c.country_name
ORDER BY
    c.country_name;