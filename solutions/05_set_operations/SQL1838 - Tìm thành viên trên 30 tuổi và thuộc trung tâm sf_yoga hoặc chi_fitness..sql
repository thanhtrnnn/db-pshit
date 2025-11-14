-- Tables: sf_yoga, chi_fitness
-- Technique: UNION ALL (dialect: Mysql)

SELECT member_id, name, age, gender
FROM sf_yoga
WHERE age > 30

UNION ALL

SELECT member_id, name, age, gender
FROM chi_fitness
WHERE age > 30;