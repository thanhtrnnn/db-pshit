 -- Tables: mine, mining_data
 -- Technique: JOIN, GROUP BY (dialect: Mysql)
 
 SELECT
  m.name AS mine_name,
  SUM(md.quantity) AS total_gold_silver_quantity
 FROM
  mine AS m
 JOIN
  mining_data AS md
 ON
  m.id = md.mine_id
 WHERE
  md.mineral IN ('gold', 'silver')
 GROUP BY
  m.name;
 