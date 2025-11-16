--- Tables: covid
--- Technique: Filtering and Aggregation (dialect: Mysql)

SELECT
    COUNT(covid_id)
FROM
    covid
WHERE
    city = 'New York City' AND test_date >= CURDATE() - INTERVAL 7 DAY;