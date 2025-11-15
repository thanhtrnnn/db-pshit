-- Tables: AirForce_Equipment, Army_Equipment
-- Technique: UNION (dialect: Mysql)

SELECT equipment, quantity
FROM AirForce_Equipment
WHERE country = 'India'

UNION ALL

SELECT equipment, quantity
FROM Army_Equipment
WHERE country = 'India';