 -- Tables: paris_escooters, nyc_escooters
 -- Technique: UNION ALL, Aggregate (dialect: Mysql)

SELECT
    SUM(available)
FROM
    (
        SELECT available
        FROM paris_escooters
        WHERE last_updated >= '2022-01-01'
        UNION ALL
        SELECT available
        FROM nyc_escooters
        WHERE last_updated >= '2022-01-01'
    ) AS combined_escooters;