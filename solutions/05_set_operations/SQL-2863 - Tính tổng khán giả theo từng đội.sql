-- Tables: TeamStats
-- Technique: UNION ALL, GROUP BY, ORDER BY (dialect: mysql)

SELECT
    Team,
    SUM(Total_Attendance) AS Total_Attendance
FROM (
    SELECT
        HomeTeam AS Team,
        HomeAttendance AS Total_Attendance
    FROM
        TeamStats
    UNION ALL
    SELECT
        AwayTeam AS Team,
        AwayAttendance AS Total_Attendance
    FROM
        TeamStats
) AS TeamAttendance
GROUP BY
    Team
ORDER BY
    Total_Attendance DESC,
    Team ASC
LIMIT 3;