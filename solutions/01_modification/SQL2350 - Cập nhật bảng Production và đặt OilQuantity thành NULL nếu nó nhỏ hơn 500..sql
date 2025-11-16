--- Tables: Production
--- Technique: UPDATE (dialect: MySQL)
UPDATE Production
SET OilQuantity = NULL
WHERE OilQuantity < 500;