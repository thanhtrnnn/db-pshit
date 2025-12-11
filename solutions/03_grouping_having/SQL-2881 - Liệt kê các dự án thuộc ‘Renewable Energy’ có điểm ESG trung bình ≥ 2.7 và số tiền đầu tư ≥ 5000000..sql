-- Tables: esg_factors, impact_investments
-- Technique: JOIN (dialect: mysql)


SELECT
  ii.project,
  ii.location,
  ii.amount,
  AVG(ef.environment + ef.social + ef.governance) / 3 AS avg_esg
FROM impact_investments AS ii
JOIN esg_factors AS ef
  ON ii.company_id = ef.company_id
WHERE
  ii.sector = 'Renewable Energy'
  AND (ef.environment + ef.social + ef.governance) / 3 >= 2.7
  AND ii.amount >= 5000000
GROUP BY
  ii.project,
  ii.location,
  ii.amount
ORDER BY
  ii.amount DESC;