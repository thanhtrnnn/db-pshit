--- Tables: athletes
--- Technique: Group By, Having (dialect: Mysql)

SELECT athlete_name
FROM athletes
WHERE sport IN ('Baseball', 'Football')
GROUP BY athlete_id, athlete_name
HAVING COUNT(DISTINCT sport) = 2;