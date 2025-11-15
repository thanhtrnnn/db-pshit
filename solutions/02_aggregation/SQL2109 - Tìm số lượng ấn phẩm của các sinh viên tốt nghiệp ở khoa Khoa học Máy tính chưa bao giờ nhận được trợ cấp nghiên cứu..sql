-- Tables: students, publications
-- Technique: JOIN (dialect: MySQL)

SELECT
    COUNT(p.publication_id)
FROM
    students AS s
JOIN
    publications AS p ON s.student_id = p.student_id
WHERE
    s.department = 'Khoa học Máy tính' AND s.grant_recipient = FALSE;