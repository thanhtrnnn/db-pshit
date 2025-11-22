 -- Tables: north_programs, south_programs
 -- Technique: UNION ALL, COUNT, LIKE (dialect: MySQL)
 
 SELECT COUNT(*)
 FROM north_programs
 WHERE program LIKE '%Immunization%'
 UNION ALL
 SELECT COUNT(*)
 FROM south_programs
 WHERE program LIKE '%Immunization%';