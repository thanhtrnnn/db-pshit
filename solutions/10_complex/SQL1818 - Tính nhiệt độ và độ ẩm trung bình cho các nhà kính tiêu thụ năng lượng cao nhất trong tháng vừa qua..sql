-- Tables: greenhouse, sensor
-- Technique: Subquery (dialect: Mysql)

SELECT
    s.greenhouse_id,
    g.name,
    AVG(s.temperature) AS avg_temperature,
    AVG(s.humidity) AS avg_humidity
FROM
    sensor AS s
JOIN
    greenhouse AS g ON s.greenhouse_id = g.id
WHERE
    YEAR(s.recorded_at) = 2025
    AND MONTH(s.recorded_at) = 8
    AND s.greenhouse_id = (
        SELECT
            greenhouse_id
        FROM
            sensor
        WHERE
            YEAR(recorded_at) = 2025 AND MONTH(recorded_at) = 8
        GROUP BY
            greenhouse_id
        ORDER BY
            SUM(energy_consumption) DESC
        LIMIT 1
    )
GROUP BY
    s.greenhouse_id,
    g.name;