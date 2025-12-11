-- Tables: provider, renewable_source, power_generation, region
-- Technique: JOIN (dialect: mysql)

SELECT
    p.name AS provider_name,
    SUM(pg.power_generated) AS total_power_generated
FROM
    provider AS p
JOIN
    renewable_source AS rs ON p.id = rs.provider_id
JOIN
    power_generation AS pg ON rs.id = pg.source_id
JOIN
    region AS r ON p.region_id = r.id
WHERE
    r.name LIKE '%st'
    AND pg.date BETWEEN '2021-01-01' AND '2021-03-31'
    AND pg.power_generated > 0
GROUP BY
    p.id, p.name
HAVING
    SUM(CASE WHEN rs.name = 'Solar' THEN 1 ELSE 0 END) > 0
    AND SUM(CASE WHEN rs.name = 'Wind' THEN 1 ELSE 0 END) > 0
ORDER BY
    total_power_generated DESC;