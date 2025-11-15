-- Tables: bookings, hotels_types
-- Technique: JOIN, Subquery, Aggregation (dialect: MySQL)

SELECT AVG(total_revenue_per_hotel)
FROM (
    SELECT SUM(b.revenue) AS total_revenue_per_hotel
    FROM bookings b
    JOIN hotels_types ht ON b.hotel_id = ht.hotel_id
    WHERE ht.type = 'Resort'
    GROUP BY ht.hotel_id
) AS resort_hotel_revenues;