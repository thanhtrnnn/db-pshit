-- Tables: customers, customer_transactions
-- Technique: LEFT JOIN (dialect: MySQL)

Delete from customers
where customer_id not in (
    select customer_id
    from customer_transactions
)