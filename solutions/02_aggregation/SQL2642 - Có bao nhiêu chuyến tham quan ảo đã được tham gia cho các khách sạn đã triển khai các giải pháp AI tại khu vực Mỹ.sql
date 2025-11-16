-- Tables: hotels, ai_solutions, virtual_tours
-- Technique: Joins, Aggregation (dialect: Mysql)

SELECT
    COUNT(vt.tour_id) AS total_tours_engaged
FROM
    hotels AS h
JOIN
    ai_solutions AS ai ON h.hotel_id = ai.hotel_id
JOIN
    virtual_tours AS vt ON h.hotel_id = vt.hotel_id
WHERE
    h.region = 'Americas';