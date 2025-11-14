--- Tables: companies
--- Technique: aggregation (dialect: Sql Server)

SELECT
    company_name
FROM
    companies
GROUP BY
    company_name
HAVING
    COUNT(DISTINCT country) > 1;