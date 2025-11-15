--- Tables: sports, regions, games
--- Technique: JOIN (dialect: Mysql)

SELECT
    AVG(g.price) AS avg_price
FROM
    games AS g
JOIN
    sports AS s ON g.sport_id = s.id
JOIN
    regions AS r ON g.region_id = r.id
WHERE
    s.name = 'Bóng đá' AND r.name = 'Trung Tây';