 -- Tables: teams, games, games_results
 -- Technique: GROUP BY, Conditional Aggregation (dialect: Mysql)
 
 SELECT
  t.team_name,
  YEAR(g.game_date) AS year,
  COUNT(gr.game_id) AS total_games,
  SUM(CASE WHEN gr.result = 'win' THEN 1 ELSE 0 END) AS wins,
  SUM(CASE WHEN gr.result = 'loss' THEN 1 ELSE 0 END) AS losses,
  SUM(CASE WHEN gr.result = 'draw' THEN 1 ELSE 0 END) AS draws
 FROM
  teams AS t
 JOIN
  games AS g ON t.team_id = g.team_id
 JOIN
  games_results AS gr ON g.game_id = gr.game_id AND g.team_id = gr.team_id
 GROUP BY
  t.team_name,
  YEAR(g.game_date)
 ORDER BY
  t.team_name,
  year;
 