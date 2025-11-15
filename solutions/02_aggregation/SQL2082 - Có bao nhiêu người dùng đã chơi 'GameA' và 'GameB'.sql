-- Tables: users_games
-- Technique: Group By, Count Distinct (dialect: MySQL)

SELECT
    game_id AS `Mã trận đấu`,
    COUNT(DISTINCT user_id) AS `Số lượng người dùng duy nhất`
FROM
    users_games
WHERE
    game_id IN (1, 2)
GROUP BY
    game_id;