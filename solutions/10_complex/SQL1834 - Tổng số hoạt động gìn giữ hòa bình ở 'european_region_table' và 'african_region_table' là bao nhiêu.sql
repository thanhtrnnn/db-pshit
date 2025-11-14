 -- Tables: european_region_table, african_region_table
 -- Technique: Sum of subquery counts (dialect: MySQL)

 SELECT
  (SELECT COUNT(*) FROM european_region_table) +
  (SELECT COUNT(*) FROM african_region_table) AS total_activity;