-- Tables: login_attempts
-- Technique: Group By, Aggregate Functions (dialect: Mysql)

SELECT
    user_id,
    TIMESTAMPDIFF(MINUTE, MIN(timestamp), MAX(timestamp)) AS `MAX(time_diff)`
FROM
    login_attempts
WHERE
    DATE(timestamp) = '2022-01-01'
GROUP BY
    user_id
HAVING
    COUNT(*) > 5;