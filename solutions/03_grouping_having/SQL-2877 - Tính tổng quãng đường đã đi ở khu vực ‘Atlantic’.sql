-- Tables: vessels, voyages
-- Technique: JOIN, GROUP BY, HAVING (dialect: Mysql)
SELECT
    v.type,
    SUM(vo.distance) AS total_distance_atlantic
FROM
    vessels AS v
JOIN
    voyages AS vo
ON
    v.id = vo.vessel_id
WHERE
    vo.region = 'Atlantic'
GROUP BY
    v.type
HAVING
    SUM(vo.distance) >= 1000
ORDER BY
    total_distance_atlantic DESC;