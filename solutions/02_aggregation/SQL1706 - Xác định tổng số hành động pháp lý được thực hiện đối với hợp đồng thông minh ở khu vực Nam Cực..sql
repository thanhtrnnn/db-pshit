-- Tables: smart_contracts, regulatory_actions
-- Technique: JOIN, Filtering, Aggregate (dialect: Mysql)

SELECT
  COUNT(ra.action_id)
FROM smart_contracts AS sc
JOIN regulatory_actions AS ra
  ON sc.contract_id = ra.contract_id
WHERE
  sc.region = 'Antarctic';