-- Tables: student_info, student_disability_accommodations
-- Technique: JOIN, GROUP BY, HAVING (dialect: MySQL)
SELECT
    si.student_id,
    si.name
FROM
    student_info AS si
JOIN
    student_disability_accommodations AS sda ON si.student_id = sda.student_id
GROUP BY
    si.student_id, si.name
HAVING
    COUNT(DISTINCT sda.department) > 1;