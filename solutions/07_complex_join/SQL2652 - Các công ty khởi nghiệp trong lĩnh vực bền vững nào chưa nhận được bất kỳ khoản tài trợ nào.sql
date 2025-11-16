-- Tables: company, investment_round
-- Technique: LEFT JOIN (dialect: Mysql)
SELECT
  c.name
FROM
  company AS c
LEFT JOIN
  investment_round AS ir
ON
  c.id = ir.company_id
WHERE
  c.industry = 'Bền vững' AND ir.id IS NULL;