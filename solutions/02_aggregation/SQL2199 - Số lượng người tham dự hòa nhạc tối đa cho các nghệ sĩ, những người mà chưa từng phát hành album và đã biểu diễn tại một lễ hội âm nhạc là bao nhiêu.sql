 -- Tables: Concerts, Artists
 -- Technique: JOIN (dialect: Mysql)

 SELECT
  MAX(C.attendees)
 FROM
  Concerts AS C
 JOIN
  Artists AS A ON C.artist_id = A.artist_id
 WHERE
  A.albums = 0
  AND A.festivals = 1;