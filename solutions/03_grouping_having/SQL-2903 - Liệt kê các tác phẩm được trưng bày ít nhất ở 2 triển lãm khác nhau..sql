-- Tables: Artworks, Exhibitions
-- Technique: Group By, Having (dialect: Mysql)

SELECT
    A.Title,
    COUNT(DISTINCT E.ExhibitionID) AS exhibitions_count
FROM
    Artworks AS A
JOIN
    Exhibitions AS E
ON
    A.ArtworkID = E.ArtworkID
GROUP BY
    A.ArtworkID,
    A.Title
HAVING
    COUNT(DISTINCT E.ExhibitionID) >= 2
ORDER BY
    exhibitions_count DESC;