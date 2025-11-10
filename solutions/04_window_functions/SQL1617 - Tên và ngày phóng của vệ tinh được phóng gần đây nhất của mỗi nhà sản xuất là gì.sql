-- Tables: manufacturers, satellites
-- Technique: window_functions (dialect: Sql Server)

SELECT
    m.name AS manufacturer,
    s.name AS satellite,
    s.launch_date
FROM
    manufacturers AS m
JOIN
    (
        SELECT
            id,
            manufacturer_id,
            name,
            launch_date,
            ROW_NUMBER() OVER (PARTITION BY manufacturer_id ORDER BY launch_date DESC) AS rn
        FROM
            satellites
    ) AS s
ON
    m.id = s.manufacturer_id
WHERE
    s.rn = 1
ORDER BY
    m.name;