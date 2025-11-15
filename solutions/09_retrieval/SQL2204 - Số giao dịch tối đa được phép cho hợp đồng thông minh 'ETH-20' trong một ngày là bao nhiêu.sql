 -- Tables: smart_contracts, daily_limits
 -- Technique: JOIN (dialect: Mysql)

 SELECT
  dl.max_transactions
 FROM smart_contracts AS sc
 JOIN daily_limits AS dl
  ON sc.id = dl.smart_contract_id
 WHERE
  sc.name = 'ETH-20';