--- Tables: Songs, Artists
--- Technique: UPDATE with JOIN (dialect: MySQL)
UPDATE Songs AS s
JOIN Artists AS a ON s.artist = a.name
SET s.streams = 1500000
WHERE s.title = 'Melody of Freedom'
  AND a.country = 'Brazil';