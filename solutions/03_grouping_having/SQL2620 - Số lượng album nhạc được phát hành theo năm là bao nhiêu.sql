--- Tables: MusicAlbums
--- Technique: GROUP BY (dialect: MySQL)

SELECT
  ReleaseYear,
  COUNT(AlbumID) AS Num_Albums
FROM MusicAlbums
GROUP BY
  ReleaseYear
ORDER BY
  ReleaseYear;