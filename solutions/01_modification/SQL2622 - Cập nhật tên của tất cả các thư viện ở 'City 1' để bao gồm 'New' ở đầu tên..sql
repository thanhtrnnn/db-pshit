 -- Tables: cities, libraries
-- Technique: UPDATE (dialect: Mysql)

UPDATE libraries
SET name = CONCAT('New ', name)
WHERE city_id = (SELECT id FROM cities WHERE name = 'City 1');