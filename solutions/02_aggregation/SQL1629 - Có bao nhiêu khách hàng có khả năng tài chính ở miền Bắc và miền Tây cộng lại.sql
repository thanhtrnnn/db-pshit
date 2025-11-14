--- Tables: financially_capable
--- Technique: aggregation (dialect: Sql Server)

SELECT
    COUNT(customer_id) AS count
FROM
    financially_capable
WHERE
    region IN ('North', 'West');