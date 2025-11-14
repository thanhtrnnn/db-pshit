--- Tables: marine_species
--- Technique: WHERE clause (dialect: Mysql)
SELECT
  name
FROM
  marine_species
WHERE
  Atlantic XOR Indian;