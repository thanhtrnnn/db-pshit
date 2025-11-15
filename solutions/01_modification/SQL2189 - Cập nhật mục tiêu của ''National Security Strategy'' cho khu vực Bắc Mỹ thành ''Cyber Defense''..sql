-- Tables: region, strategy
-- Technique: UPDATE (dialect: Mysql)

UPDATE strategy
SET focus = 'Cyber Defense'
WHERE name = 'National Security Strategy'
  AND region_id = (SELECT id FROM region WHERE name = 'Bắc Mỹ');