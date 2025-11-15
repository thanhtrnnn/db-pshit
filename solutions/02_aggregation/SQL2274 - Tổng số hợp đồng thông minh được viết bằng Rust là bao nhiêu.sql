 -- Tables: smart_contracts
 -- Technique: Aggregate function (dialect: Mysql)

SELECT
  COUNT(id) AS total_rust_contracts
FROM smart_contracts
WHERE
  language = 'Rust';