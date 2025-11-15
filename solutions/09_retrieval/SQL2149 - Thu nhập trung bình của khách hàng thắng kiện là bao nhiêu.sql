-- Tables: cases, clients
-- Technique: JOIN, Aggregate Function (dialect: MySQL)

SELECT
  AVG(c.income) AS average_income
FROM cases AS ca
JOIN clients AS c
  ON ca.client_id = c.client_id
WHERE
  ca.outcome = 'win';