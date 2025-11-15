 -- Tables: regions, disaster_preparedness_kits
 -- Technique: Group By (dialect: Mysql)

 SELECT
  dpk.region,
  SUM(dpk.quantity) AS total_kits_distributed
 FROM
  disaster_preparedness_kits AS dpk
 GROUP BY
  dpk.region;