-- Tables: Rural_Infrastructure_Projects
-- Technique: Aggregate function (MAX), Filtering (WHERE) (dialect: MySQL)

SELECT MAX(budget) AS `MAX(budget)`
FROM Rural_Infrastructure_Projects
WHERE country = 'Asia';