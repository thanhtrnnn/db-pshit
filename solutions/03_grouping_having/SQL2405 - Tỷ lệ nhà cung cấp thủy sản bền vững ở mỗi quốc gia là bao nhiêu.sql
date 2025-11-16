-- Tables: suppliers
-- Technique: Aggregation (dialect: Mysql)

SELECT
    country,
    (SUM(sustainable_seafood) * 100.0 / COUNT(*)) AS percentage_sustainable_suppliers
FROM
    suppliers
GROUP BY
    country
ORDER BY
    country;