-- Tables: buildings
-- Technique: Group By, Aggregate Function (dialect: Mysql)

SELECT
    state,
    MAX(energy_efficiency_rating) AS max_rating
FROM
    buildings
WHERE
    state IN ('CA', 'NY', 'FL', 'TX')
GROUP BY
    state;