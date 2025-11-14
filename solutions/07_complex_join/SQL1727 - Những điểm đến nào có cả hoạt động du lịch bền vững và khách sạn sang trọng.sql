--- Tables: Destinations, SustainableTourism, Hotels
--- Technique: Joins (dialect: Mysql)

SELECT DISTINCT D.name
FROM Destinations AS D
JOIN SustainableTourism AS ST ON D.name = ST.destination
JOIN Hotels AS H ON D.name = H.country
WHERE H.category = 'Luxury';