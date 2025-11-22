-- Tables: companies, funding
-- Technique: Left Join, Aggregation (dialect: Mysql)
SELECT
    COUNT(DISTINCT c.id) AS unique_founders,
    SUM(COALESCE(f.amount, 0)) AS total_funding
FROM
    companies AS c
LEFT JOIN
    funding AS f ON c.id = f.company_id
WHERE
    c.industry = 'Energy' AND c.founded_date < '2015-01-01';