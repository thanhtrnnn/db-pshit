 -- Tables: WorkoutSessions
 -- Technique: Group By (dialect: MySQL)

 SELECT
  MemberID,
  SUM(Duration) AS TotalDuration
 FROM
  WorkoutSessions
 GROUP BY
  MemberID;