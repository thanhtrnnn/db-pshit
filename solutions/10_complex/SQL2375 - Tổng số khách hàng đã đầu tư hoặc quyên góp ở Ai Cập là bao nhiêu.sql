-- Tables: investments, donations
-- Technique: UNION (dialect: Mysql)

SELECT
    COUNT(DISTINCT client_name) AS total_customers
FROM
    (
        SELECT client_name
        FROM investments
        WHERE country = 'Egypt'
        UNION ALL
        SELECT client_name
        FROM donations
        WHERE country = 'Egypt'
    ) AS egypt_clients;