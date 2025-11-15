-- Tables: Artists, Performances
-- Technique: JOIN, Aggregation (dialect: Mysql)
SELECT
    AVG(A.Age) AS `AVG(A.Age)`
FROM
    Artists AS A
JOIN
    Performances AS P ON A.ArtistID = P.ArtistID
WHERE
    A.Genre = 'Country';