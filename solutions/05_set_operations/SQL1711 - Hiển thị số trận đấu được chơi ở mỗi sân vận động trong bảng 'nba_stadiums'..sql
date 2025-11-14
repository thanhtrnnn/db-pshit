--- Tables: nba_stadiums, nba_games
--- Technique: Union, Group By (dialect: Mysql)

SELECT
    ns.stadium_id,
    COUNT(t.game_stadium_id) AS total_games
FROM
    nba_stadiums AS ns
JOIN (
    SELECT home_stadium_id AS game_stadium_id FROM nba_games
    UNION ALL
    SELECT away_stadium_id AS game_stadium_id FROM nba_games
) AS t ON ns.stadium_id = t.game_stadium_id
GROUP BY
    ns.stadium_id
ORDER BY
    ns.stadium_id;