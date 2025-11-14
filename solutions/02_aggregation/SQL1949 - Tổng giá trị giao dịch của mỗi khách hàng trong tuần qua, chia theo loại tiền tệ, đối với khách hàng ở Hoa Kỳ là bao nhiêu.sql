-- Tables: customers, transactions
-- Technique: JOIN, WHERE, GROUP BY (dialect: Mysql)
SELECT
    c.customer_id,
    t.currency,
    SUM(t.amount) AS total_transaction_value
FROM
    customers AS c
JOIN
    transactions AS t ON c.customer_id = t.customer_id
WHERE
    c.country = 'Hoa Kỳ' -- Filter for customers in the USA
    AND t.transaction_date >= CURDATE() - INTERVAL 7 DAY -- Filter for transactions in the last 7 days
GROUP BY
    c.customer_id,
    t.currency
ORDER BY
    c.customer_id,
    t.currency;