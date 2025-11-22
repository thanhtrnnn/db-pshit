SELECT AVG(budget) AS average_budget
FROM (
    SELECT budget, release_year
    FROM movies
    UNION ALL
    SELECT budget, release_year
    FROM tv_shows
) AS combined_shows
WHERE release_year >= (YEAR(CURDATE()) - 4);