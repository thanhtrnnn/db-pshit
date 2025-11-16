 -- Tables: faculty, grant, student
 -- Technique: Joins (dialect: Mysql)

SELECT DISTINCT F.name
FROM faculty AS F
INNER JOIN student AS S ON F.id = S.supervisor_id
INNER JOIN `grant` AS G ON F.id = G.faculty_id
WHERE S.program = 'Postgraduate';