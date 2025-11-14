DELETE FROM clients
WHERE id NOT IN (
    SELECT DISTINCT client_id
    FROM investments
    WHERE fund_type = 'Socially Responsible'
);