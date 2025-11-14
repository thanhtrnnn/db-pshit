-- Tables: Movies, StarsIn, MovieStar
-- Technique: JOIN (dialect: Mysql)

SELECT
    MS.name
FROM
    Movies AS M
JOIN
    StarsIn AS SI ON M.title = SI.movieTitle AND M.year = SI.movieYear
JOIN
    MovieStar AS MS ON SI.starName = MS.name
WHERE
    M.title = 'Stars War' AND MS.gender = 'F';