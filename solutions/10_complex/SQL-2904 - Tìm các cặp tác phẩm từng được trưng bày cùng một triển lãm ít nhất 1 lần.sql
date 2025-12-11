 -- Tables: Artworks, Exhibitions
 -- Technique: Self-join, Group By (dialect: Mysql)
 SELECT
  A1.Title AS Title1,
  A2.Title AS Title2,
  COUNT(E1.ExhibitionID) AS co_exhibit_count
 FROM
  Exhibitions AS E1
  INNER JOIN Exhibitions AS E2 ON E1.ExhibitionID = E2.ExhibitionID
  AND E1.ArtworkID < E2.ArtworkID
  INNER JOIN Artworks AS A1 ON E1.ArtworkID = A1.ArtworkID
  INNER JOIN Artworks AS A2 ON E2.ArtworkID = A2.ArtworkID
 GROUP BY
  A1.Title,
  A2.Title
 ORDER BY
  co_exhibit_count DESC;