-- Tables: teams, games
-- Technique: Joins, Aggregation (dialect: Mysql)
SELECT
    AVG(G.attendance)
FROM
    games AS G
JOIN
    teams AS T ON G.team_id = T.team_id
WHERE
    T.team_name = 'Lakers';