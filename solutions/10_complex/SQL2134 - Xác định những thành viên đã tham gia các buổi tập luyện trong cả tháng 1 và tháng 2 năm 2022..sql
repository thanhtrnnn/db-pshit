 -- Tables: Members, Workouts
 -- Technique: Group By with Having (dialect: Mysql)

 SELECT
  m.MemberID,
  m.FirstName,
  m.LastName
 FROM
  Members AS m
 JOIN
  Workouts AS w
 ON
  m.MemberID = w.MemberID
 WHERE
  YEAR(w.WorkoutDate) = 2022 AND MONTH(w.WorkoutDate) IN (1, 2)
 GROUP BY
  m.MemberID,
  m.FirstName,
  m.LastName
 HAVING
  COUNT(DISTINCT MONTH(w.WorkoutDate)) = 2
 ORDER BY
  m.MemberID;
