-- Tables: Albums
-- Technique: Group By, Having (dialect: MySQL)
SELECT ArtistID
FROM Albums
GROUP BY ArtistID
HAVING MIN(ReleaseYear) < 2000 AND MAX(ReleaseYear) > 2000;