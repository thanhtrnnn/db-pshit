-- Tables: arctic_region, polar_bear_observation
-- Technique: JOIN, GROUP BY (dialect: Mysql)

SELECT
    ar.region_name,
    SUM(pbo.observation) AS total_polar_bears
FROM
    arctic_region AS ar
JOIN
    polar_bear_observation AS pbo
    ON ar.region_id = pbo.region_id
GROUP BY
    ar.region_name;