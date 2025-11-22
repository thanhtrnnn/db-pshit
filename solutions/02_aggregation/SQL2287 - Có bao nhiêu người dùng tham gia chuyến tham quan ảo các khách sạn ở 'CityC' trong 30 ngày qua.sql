-- Tables: hotels, virtualTours, userInteractions
-- Technique: JOIN, Filtering (dialect: Mysql)

SELECT
    COUNT(DISTINCT ui.user_id)
FROM
    hotels AS h
JOIN
    virtualTours AS vt ON h.hotel_id = vt.hotel_id
JOIN
    userInteractions AS ui ON vt.tour_id = ui.tour_id
WHERE
    h.city = 'CityC'
    AND ui.interaction_date >= CURDATE() - INTERVAL 30 DAY;