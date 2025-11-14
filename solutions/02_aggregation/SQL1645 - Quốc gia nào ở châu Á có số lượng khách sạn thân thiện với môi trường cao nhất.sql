 -- Tables: hotels
 -- Technique: Aggregation, Filtering, Ordering (dialect: Sql Server)

 SELECT TOP 1 region, COUNT(hotel_id) AS num_hotels
 FROM hotels
 WHERE is_eco_friendly = 1
 GROUP BY region
 ORDER BY num_hotels DESC;