-- Tables: lifelong_learning
-- Technique: Group By, Aggregate Functions (dialect: Mysql)
SELECT
    FLOOR(age / 10) * 10 AS age_group,
    ROUND(COUNT(completion_date) / COUNT(*), 4) AS completion_rate
FROM
    lifelong_learning
GROUP BY
    age_group
ORDER BY
    age_group;