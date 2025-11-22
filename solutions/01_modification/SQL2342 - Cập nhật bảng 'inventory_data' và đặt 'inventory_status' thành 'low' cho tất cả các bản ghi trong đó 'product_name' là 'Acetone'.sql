-- Tables: inventory_data
-- Technique: UPDATE (dialect: MySQL)

UPDATE inventory_data
SET inventory_status = 'low'
WHERE product_name = 'Acetone';