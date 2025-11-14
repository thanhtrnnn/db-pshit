-- Tables: students, student_publications
-- Technique: modification (dialect: Mysql)
DELETE s
FROM students s
LEFT JOIN student_publications sp ON s.id = sp.student_id
WHERE sp.student_id IS NULL;