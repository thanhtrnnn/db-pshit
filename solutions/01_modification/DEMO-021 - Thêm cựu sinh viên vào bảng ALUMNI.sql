-- Tables: STUDENT, ALUMNI
-- Technique: Insert into select (dialect: Mysql)

INSERT INTO ALUMNI (SID, FullName)
SELECT SID, FullName
FROM STUDENT
WHERE Graduated = 1;