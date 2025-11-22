--- Tables: artists, albums
--- Technique: INSERT (dialect: MySQL)
INSERT INTO albums (album_id, title, artist_id)
VALUES (5, 'A Long Way Home', (SELECT artist_id FROM artists WHERE name = 'Ayo' AND community = 'African American'));