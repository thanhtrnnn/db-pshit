-- Imported from batch1.md
-- Title: Class more than 5 student

SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;
