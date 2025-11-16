 -- Tables: ports, cargo_operations
 -- Technique: JOIN (dialect: MySQL)
 
 SELECT
  SUM(co.weight)
 FROM cargo_operations AS co
 JOIN ports AS p
  ON co.port_id = p.id
 WHERE
  co.company = 'Orion Lines' AND p.name = 'Port of Hong Kong';