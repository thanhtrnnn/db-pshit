-- Tables: AIRCRAFT_INFO
-- Technique: Subquery (dialect: Mysql)

SELECT name
FROM AIRCRAFT_INFO
WHERE type = 'Military' AND cost = (
    SELECT MAX(cost)
    FROM AIRCRAFT_INFO
    WHERE type = 'Military'
);