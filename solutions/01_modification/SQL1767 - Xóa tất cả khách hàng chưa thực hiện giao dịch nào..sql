-- Tables: customers, customer_transactions
-- Technique: LEFT JOIN (dialect: MySQL)

DELETE c
FROM customers c
LEFT JOIN customer_transactions ct ON c.customer_id = ct.customer_id
WHERE ct.transaction_id IS NULL;