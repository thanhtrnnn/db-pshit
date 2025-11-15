-- Tables: ProtectedAreas
-- Technique: GROUP BY (dialect: Mysql)

SELECT
    species AS animal_species,
    SUM(animals) AS total_animals
FROM
    ProtectedAreas
GROUP BY
    species;