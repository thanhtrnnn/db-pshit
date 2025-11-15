 -- Tables: emergency_calls, fire_incidents
-- Technique: UNION ALL, Aggregate Function (dialect: MySQL)

SELECT
    t.district,
    t.type,
    AVG(t.response_time) AS avg
FROM
    (
        SELECT
            district,
            response_time,
            'emergency calls' AS type
        FROM
            emergency_calls
        UNION ALL
        SELECT
            district,
            response_time,
            'fire incidents' AS type
        FROM
            fire_incidents
    ) AS t
GROUP BY
    t.district,
    t.type
ORDER BY
    t.district, t.type;