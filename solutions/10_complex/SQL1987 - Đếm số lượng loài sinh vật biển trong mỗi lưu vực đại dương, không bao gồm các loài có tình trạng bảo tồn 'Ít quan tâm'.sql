-- Tables: species, ocean_basin
-- Technique: UPDATE with LEFT JOIN and Subquery (dialect: MySQL)

UPDATE ocean_basin ob
LEFT JOIN (
    SELECT
        s.habitat,
        COUNT(s.id) AS species_count_for_habitat
    FROM
        species s
    WHERE
        s.conservation_status <> 'Ít quan tâm'
    GROUP BY
        s.habitat
) AS s_counts ON ob.name = s_counts.habitat
SET ob.species_count = COALESCE(s_counts.species_count_for_habitat, 0);