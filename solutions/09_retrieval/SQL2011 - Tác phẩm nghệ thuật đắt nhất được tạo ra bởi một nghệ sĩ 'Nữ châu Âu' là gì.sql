-- Tables: Artists, Artworks
-- Technique: JOIN, Filtering, Ordering (dialect: Mysql)

SELECT
    A.artist_name,
    AW.artwork_name,
    AW.price
FROM
    Artists AS A
JOIN
    Artworks AS AW
ON
    A.id = AW.artist_id
WHERE
    A.gender = 'Female' AND A.ethnicity = 'European'
ORDER BY
    AW.price DESC
LIMIT 1;