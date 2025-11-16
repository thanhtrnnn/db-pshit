-- Tables: Farm, Measurement
-- Technique: JOIN, GROUP BY, ORDER BY, LIMIT (dialect: Mysql)

SELECT
    f.country,
    AVG(m.dissolved_oxygen) AS average_dissolved_oxygen
FROM
    Farm AS f
JOIN
    Measurement AS m ON f.id = m.farm_id
GROUP BY
    f.country
ORDER BY
    average_dissolved_oxygen DESC
LIMIT 3;