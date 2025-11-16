-- Tables: hotel_revenue, museum_visitors
-- Technique: Subquery (dialect: Mysql)

SELECT
    (SELECT AVG(daily_revenue)
     FROM hotel_revenue
     WHERE country IN ('Germany', 'Portugal')) AS average_hotel_revenue,
    (SELECT AVG(daily_visitors)
     FROM museum_visitors
     WHERE country IN ('Germany', 'Portugal')) AS average_museum_visitors;