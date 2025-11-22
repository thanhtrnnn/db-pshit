-- Tables: vessels
-- Technique: Subquery (dialect: Mysql)

SELECT
    id,
    name,
    type,
    cargo_capacity
FROM
    vessels
WHERE
    type = 'Tanker' AND cargo_capacity > (
        SELECT
            AVG(cargo_capacity)
        FROM
            vessels
        WHERE
            type = 'Tanker'
    );