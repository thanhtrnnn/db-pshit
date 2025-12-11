-- Tables: TeamStats
-- Technique: Aggregation (dialect: mysql)

SELECT 
    t.Team,
    AVG(CASE WHEN t.Role = 'Home' THEN t.Attendance END) AS Avg_As_Home,
    AVG(CASE WHEN t.Role = 'Away' THEN t.Attendance END) AS Avg_As_Away
FROM (
    SELECT HomeTeam AS Team, HomeAttendance AS Attendance, 'Home' AS Role 
    FROM TeamStats
    
    UNION ALL
    
    SELECT AwayTeam AS Team, AwayAttendance AS Attendance, 'Away' AS Role 
    FROM TeamStats
) AS t
GROUP BY t.Team
ORDER BY t.Team;