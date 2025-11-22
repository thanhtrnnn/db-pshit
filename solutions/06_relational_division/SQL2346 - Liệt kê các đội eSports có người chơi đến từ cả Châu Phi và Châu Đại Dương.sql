--- Tables: teams
--- Technique: Group By, Having (dialect: MySQL)

SELECT id
FROM teams
WHERE region IN ('Châu Phi', 'Châu Đại Dương')
GROUP BY id
HAVING COUNT(DISTINCT region) = 2;