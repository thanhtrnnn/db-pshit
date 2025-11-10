-- Tables: companies
-- Technique: aggregation_grouped (dialect: Sql Server)

SELECT
    company_name
FROM
    companies
GROUP BY
    company_name
HAVING
    COUNT(DISTINCT country) > 1
ORDER BY
    company_name;