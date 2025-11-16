--- Tables: eco_hotels, museum_visits
--- Technique: UNION ALL (dialect: Mysql)

SELECT SUM(revenue) AS `SUM(revenue)`
FROM eco_hotels
WHERE country = 'Germany'

UNION ALL

SELECT SUM(amount) AS `SUM(revenue)`
FROM museum_visits
WHERE country = 'Germany';