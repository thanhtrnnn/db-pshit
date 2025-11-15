-- Tables: Policyholder
-- Technique: Group By, Having (dialect: Mysql)
SELECT
    Name,
    DOB
FROM
    Policyholder
GROUP BY
    PolicyholderID, Name, DOB
HAVING
    SUM(CASE WHEN Product = 'Home' THEN 1 ELSE 0 END) >= 1
    AND SUM(CASE WHEN Product = 'Auto' THEN 1 ELSE 0 END) >= 1;