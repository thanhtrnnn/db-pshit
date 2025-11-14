-- Tables: port, vessel
-- Technique: relational_division (dialect: Sql Server)

SELECT
    vessel_name
FROM
    vessel
WHERE
    port_id IN (1, 2)
GROUP BY
    vessel_name
HAVING
    COUNT(DISTINCT port_id) = 2;