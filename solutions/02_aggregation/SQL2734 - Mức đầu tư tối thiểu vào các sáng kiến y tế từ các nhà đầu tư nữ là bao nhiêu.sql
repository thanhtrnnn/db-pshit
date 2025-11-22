-- Tables: investors, investments
-- Technique: JOIN, Aggregate Function (dialect: Mysql)

SELECT
  MIN(i.amount) AS min_investment
FROM investors AS inv
JOIN investments AS i
  ON inv.id = i.investor_id
WHERE
  inv.gender = 'Female' AND i.sector = 'Healthcare';