-- Tables: species, ocean_basin
-- Technique: UPDATE with LEFT JOIN and Subquery (dialect: MySQL)

INSERT INTO ocean_basin (name, species_count)
SELECT 
    habitat, 
    COUNT(id)
FROM 
    species
WHERE 
    conservation_status <> 'Least Concern'
GROUP BY 
    habitat;