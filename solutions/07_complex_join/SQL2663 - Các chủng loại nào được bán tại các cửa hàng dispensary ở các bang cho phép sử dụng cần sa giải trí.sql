-- Tables: dispensaries, strains, state_cannabis_regulations
-- Technique: JOIN (dialect: Mysql)

SELECT DISTINCT
  s.name
FROM strains AS s
JOIN dispensaries AS d
  ON s.dispensary_id = d.id
JOIN state_cannabis_regulations AS scr
  ON d.state = scr.state
WHERE
  scr.recreational_use = TRUE;