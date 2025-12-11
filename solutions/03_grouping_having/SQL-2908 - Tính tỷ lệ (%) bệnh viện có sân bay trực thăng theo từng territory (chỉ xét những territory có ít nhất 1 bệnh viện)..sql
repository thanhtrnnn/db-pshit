-- Tables: hospitals
-- Technique: Aggregation (dialect: Mysql)

SELECT
    territory,
    ROUND(100 * SUM(has_helipad) / COUNT(*), 2) AS helipad_rate
FROM
    hospitals
GROUP BY
    territory
ORDER BY
    helipad_rate DESC;