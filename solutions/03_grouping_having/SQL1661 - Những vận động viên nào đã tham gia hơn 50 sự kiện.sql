--- Tables: Participants
--- Technique: Group By, Having (dialect: Sql Server)

SELECT
  athlete_id
FROM Participants
GROUP BY
  athlete_id
HAVING
  COUNT(event_id) > 50;
