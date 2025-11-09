-- Imported from batch1.md
-- Title: Movie rating

(
    SELECT name AS results
    FROM Users u
    INNER JOIN MovieRating mr ON u.user_id = mr.user_id
    GROUP BY u.user_id, name
    ORDER BY COUNT(mr.user_id) DESC, name ASC
    LIMIT 1
)
UNION ALL
(
    SELECT title AS results
    FROM Movies m
    INNER JOIN MovieRating mr ON m.movie_id = mr.movie_id
    WHERE created_at >= '2020-02-01' AND created_at <= '2020-02-29'
    GROUP BY m.movie_id, title
    ORDER BY AVG(mr.rating) DESC, title ASC
    LIMIT 1
);
