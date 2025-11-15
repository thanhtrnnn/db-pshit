-- Tables: users, brand_mentions
-- Technique: JOIN, GROUP BY, ORDER BY, LIMIT (dialect: MySQL)

SELECT
    bm.brand
FROM
    users u
JOIN
    brand_mentions bm ON u.id = bm.user_id
WHERE
    u.country IN ('Hoa Kỳ', 'Canada')
    AND u.followers >= 100
GROUP BY
    bm.brand
ORDER BY
    COUNT(bm.brand) DESC
LIMIT 5;