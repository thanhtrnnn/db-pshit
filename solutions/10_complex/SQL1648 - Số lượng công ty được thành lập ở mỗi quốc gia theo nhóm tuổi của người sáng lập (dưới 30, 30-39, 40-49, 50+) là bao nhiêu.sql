--- Tables: founders, companies
--- Technique: Joins, Case statement, Group By (dialect: Sql Server)

SELECT
    c.country,
    CASE
        WHEN f.age < 30 THEN 'Under 30'
        WHEN f.age >= 30 AND f.age < 40 THEN '30-39'
        WHEN f.age >= 40 AND f.age < 50 THEN '40-49'
        WHEN f.age >= 50 THEN '50+'
        ELSE 'Unknown'
    END AS age_group,
    COUNT(DISTINCT c.company_id) AS num_companies_founded
FROM
    companies AS c
INNER JOIN
    founders AS f ON c.company_id = f.company_id
GROUP BY
    c.country,
    CASE
        WHEN f.age < 30 THEN 'Under 30'
        WHEN f.age >= 30 AND f.age < 40 THEN '30-39'
        WHEN f.age >= 40 AND f.age < 50 THEN '40-49'
        WHEN f.age >= 50 THEN '50+'
        ELSE 'Unknown'
    END
ORDER BY
    c.country,
    CASE
        WHEN f.age < 30 THEN 1
        WHEN f.age >= 30 AND f.age < 40 THEN 2
        WHEN f.age >= 40 AND f.age < 50 THEN 3
        WHEN f.age >= 50 THEN 4
        ELSE 5
    END;
