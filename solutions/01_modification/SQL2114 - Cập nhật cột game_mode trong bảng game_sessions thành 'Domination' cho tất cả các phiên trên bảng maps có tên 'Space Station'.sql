 -- Tables: game_sessions, maps
 -- Technique: UPDATE with JOIN (dialect: Mysql)

 UPDATE game_sessions gs
 JOIN maps m ON gs.map_id = m.map_id
 SET gs.game_mode = 'Domination'
 WHERE m.map_name = 'Space Station';