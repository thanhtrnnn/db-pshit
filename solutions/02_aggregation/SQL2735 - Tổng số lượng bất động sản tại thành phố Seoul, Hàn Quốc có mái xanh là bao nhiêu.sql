-- Tables: seoul_real_estate
-- Technique: Filtering (dialect: MySQL)

SELECT COUNT(*) AS `COUNT(*)`
FROM seoul_real_estate
WHERE city = 'Seoul' AND green_roof = TRUE;