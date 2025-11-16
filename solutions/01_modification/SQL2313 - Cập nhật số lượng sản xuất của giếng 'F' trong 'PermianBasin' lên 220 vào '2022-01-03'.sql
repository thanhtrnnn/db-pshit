 -- Tables: wells, production
 -- Technique: JOIN (dialect: Mysql)
 UPDATE production p
 JOIN wells w ON p.well_id = w.id
 SET p.quantity = 220
 WHERE w.name = 'F'
   AND w.region = 'PermianBasin'
   AND p.date = '2022-01-03';