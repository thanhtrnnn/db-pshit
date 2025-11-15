-- Tables: Artists, Songs
-- Technique: JOIN, GROUP BY (dialect: MySQL)

SELECT
    A.ArtistName AS `Tên nghệ sĩ`,
    A.Region AS `Khu vực`,
    COUNT(S.SongID) AS `Tổng số bài hát`,
    SUM(S.Sales) AS `Tổng doanh thu`
FROM
    Artists AS A
JOIN
    Songs AS S ON A.ArtistID = S.ArtistID
WHERE
    A.Region = 'Asia'
GROUP BY
    A.ArtistID, A.ArtistName, A.Region;