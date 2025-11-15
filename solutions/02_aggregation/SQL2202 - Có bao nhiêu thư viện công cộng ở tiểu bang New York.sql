 -- Tables: states, libraries
 -- Technique: JOIN, COUNT (dialect: Mysql)

 SELECT
  COUNT(l.id)
 FROM
  libraries AS l
 JOIN
  states AS s
 ON
  l.state_id = s.id
 WHERE
  s.name = 'New York';