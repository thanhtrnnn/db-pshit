 -- Tables: streams, tracks
 -- Technique: INSERT (dialect: MySQL)

 INSERT INTO streams (track_id, user_id, region, revenue, timestamp)
 VALUES (
  (SELECT id FROM tracks WHERE genre = 'hip-hop' LIMIT 1),
  12345,
  'Canada',
  0.99,
  '2022-03-01 14:30:00'
 );