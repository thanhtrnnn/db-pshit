 -- Tables: species_per_area
 -- Technique: Group By (dialect: MySQL)

 SELECT
  area,
  COUNT(DISTINCT species) AS num_species
 FROM
  species_per_area
 GROUP BY
  area;