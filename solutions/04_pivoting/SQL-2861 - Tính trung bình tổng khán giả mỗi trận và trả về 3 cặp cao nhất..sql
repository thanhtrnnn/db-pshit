-- Tables: TeamStats
-- Technique: Aggregation, Window Functions (dialect: mysql)

SELECT
    TeamA,
    TeamB,
    AVG(TotalAttendance) AS Avg_Total_Attendance
FROM (
    SELECT
        CASE WHEN HomeTeam < AwayTeam THEN HomeTeam ELSE AwayTeam END AS TeamA,
        CASE WHEN HomeTeam < AwayTeam THEN AwayTeam ELSE HomeTeam END AS TeamB,
        HomeAttendance + AwayAttendance AS TotalAttendance
    FROM TeamStats
) AS CombinedStats
GROUP BY
    TeamA,
    TeamB
ORDER BY
    Avg_Total_Attendance DESC
LIMIT 3;