-- Tables: nhl_players_goals, nhl_players, nhl_games
-- Technique: JOIN, Filtering (dialect: MySQL)

SELECT
    np.name AS PlayerName,
    np.team AS PlayerTeam,
    ng.date AS GameDate
FROM
    nhl_players_goals npg
JOIN
    nhl_players np ON npg.player_id = np.id
JOIN
    nhl_games ng ON npg.game_id = ng.id
WHERE
    npg.goals = 3;