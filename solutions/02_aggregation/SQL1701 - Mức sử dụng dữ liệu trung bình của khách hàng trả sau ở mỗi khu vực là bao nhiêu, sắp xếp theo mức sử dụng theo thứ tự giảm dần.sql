-- Tables: mobile_customers
-- Technique: Group By, Aggregation (dialect: Mysql)

SELECT
    region,
    AVG(data_usage) AS avg_data_usage
FROM
    mobile_customers
WHERE
    plan_type = 'postpaid'
GROUP BY
    region
ORDER BY
    avg_data_usage DESC;
