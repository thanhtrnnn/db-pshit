-- Tables: rural_infrastructure
-- Technique: Aggregate function (dialect: MySQL)

SELECT SUM(budget) AS total_budget
FROM rural_infrastructure
WHERE location = 'Village A';