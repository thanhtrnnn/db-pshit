--- Tables: species, ocean_basin
--- Technique: modification (dialect: MySQL)
UPDATE ocean_basin ob
LEFT JOIN (
    SELECT
        s.habitat,
        COUNT(s.id) AS calculated_species_count
    FROM
        species s
    WHERE
        s.conservation_status != 'Ít quan tâm'
    GROUP BY
        s.habitat
) AS sub_counts ON ob.name = sub_counts.habitat
SET
    ob.species_count = COALESCE(sub_counts.calculated_species_count, 0);