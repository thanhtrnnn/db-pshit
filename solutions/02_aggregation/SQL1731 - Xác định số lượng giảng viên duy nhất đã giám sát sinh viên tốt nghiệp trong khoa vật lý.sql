-- Tables: supervision (dialect: MySQL)
-- Technique: Filtering and Counting Distinct

SELECT COUNT(DISTINCT faculty_id)
FROM supervision
WHERE department = 'vật lý';