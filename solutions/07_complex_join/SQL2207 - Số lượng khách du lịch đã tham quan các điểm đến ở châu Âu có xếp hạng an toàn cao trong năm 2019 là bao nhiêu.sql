-- Tables: destinations, safety_ratings, tourists
-- Technique: Multiple JOINs, Filtering, Aggregation (dialect: Mysql)

SELECT
    COUNT(DISTINCT T.tourist_id) AS total_tourists
FROM
    tourists AS T
JOIN
    destinations AS D ON T.destination_id = D.destination_id
JOIN
    safety_ratings AS S ON T.destination_id = S.destination_id
WHERE
    D.continent = 'Europe'
    AND S.rating >= 4
    AND T.year = 2019;