-- Tables: company_waste
-- Technique: Filtering and Aggregation (dialect: Mysql)

SELECT SUM(waste_generated)
FROM company_waste
WHERE company IN ('Công ty A', 'Công ty B');