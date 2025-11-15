-- Tables: Artists, Albums
-- Technique: CTE, Subquery (dialect: Mysql)

WITH GenreStats AS (
    SELECT
        A.Genre,
        COUNT(DISTINCT A.ArtistID) AS Artists_Count,
        SUM(Al.Sales) AS Total_Sales
    FROM
        Artists AS A
    JOIN
        Albums AS Al ON A.ArtistID = Al.ArtistID
    GROUP BY
        A.Genre
)
SELECT
    Genre,
    Artists_Count,
    Total_Sales
FROM
    GenreStats
WHERE
    Artists_Count = (SELECT MIN(Artists_Count) FROM GenreStats);