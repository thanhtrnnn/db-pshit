-- Tables: region, provider, renewable_source, power_generation
-- Technique: JOIN (dialect: Mysql)

SELECT
    SUM(pg.power_generated) AS TotalPowerGenerated
FROM
    region AS r
JOIN
    provider AS p ON r.id = p.region_id
JOIN
    renewable_source AS rs ON p.id = rs.provider_id
JOIN
    power_generation AS pg ON rs.id = pg.source_id
WHERE
    r.name = 'Đông Bắc'
    AND rs.name = 'Solar'
    AND pg.date BETWEEN '2021-01-01' AND '2021-03-31';