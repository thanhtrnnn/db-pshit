-- Tables: complaints
-- Technique: Filtering and Aggregation (dialect: Mysql)

SELECT
    COUNT(*)
FROM
    complaints
WHERE
    complaint_type = 'data throttling'
    AND resolved = FALSE
    AND complaint_date BETWEEN '2022-04-01' AND '2022-06-30';