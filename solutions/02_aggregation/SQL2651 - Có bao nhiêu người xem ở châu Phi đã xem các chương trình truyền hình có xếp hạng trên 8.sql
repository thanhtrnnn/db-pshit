 -- Tables: TV_Shows
 -- Technique: Filtering, Aggregation (dialect: Mysql)

 SELECT SUM(viewers) AS TotalViewers
 FROM TV_Shows
 WHERE region = 'Africa' AND rating > 8;