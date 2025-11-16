-- Tables: users, posts, comments, reactions
-- Technique: Multi-LEFT JOIN with COUNT(DISTINCT) (dialect: MySQL)

SELECT
    u.country,
    COUNT(DISTINCT u.user_id) AS so_luong_nguoi_dung,
    COUNT(DISTINCT p.post_id) AS so_luong_bai_dang,
    COUNT(DISTINCT c.comment_id) AS so_luong_binh_luan,
    COUNT(DISTINCT r.reaction_id) AS so_luong_phan_ung
FROM
    users AS u
LEFT JOIN
    posts AS p ON u.user_id = p.user_id
LEFT JOIN
    comments AS c ON u.user_id = c.user_id
LEFT JOIN
    reactions AS r ON u.user_id = r.user_id
GROUP BY
    u.country
ORDER BY
    u.country;