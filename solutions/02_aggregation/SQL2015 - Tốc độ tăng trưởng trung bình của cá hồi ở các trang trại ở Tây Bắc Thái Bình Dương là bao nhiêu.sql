-- Tables: salmon_farm
-- Technique: Aggregate Function (dialect: Mysql)

SELECT AVG(growth_rate)
FROM salmon_farm
WHERE location = 'Pacific Northwest';