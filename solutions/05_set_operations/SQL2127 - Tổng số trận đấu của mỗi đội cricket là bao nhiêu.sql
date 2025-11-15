 -- Tables: CricketGames
 -- Technique: UNION ALL (dialect: Mysql)

 SELECT home_team AS team, 1 AS total_games
 FROM CricketGames
 UNION ALL
 SELECT away_team AS team, 1 AS total_games;