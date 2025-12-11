 -- Tables: Artworks, Exhibitions
 -- Technique: Multiple JOINs (dialect: Mysql)
 
 SELECT DISTINCT A.Title
 FROM Artworks AS A
 JOIN Exhibitions AS E1 ON A.ArtworkID = E1.ArtworkID
 JOIN Exhibitions AS E2 ON E1.ExhibitionID = E2.ExhibitionID
 JOIN Artworks AS A_Sunflowers ON E2.ArtworkID = A_Sunflowers.ArtworkID
 WHERE A_Sunflowers.Title = 'Sunflowers'
   AND A.Title <> 'Sunflowers'
 ORDER BY A.Title;
