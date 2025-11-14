SELECT SUM(e.budget) AS total
FROM events AS e
JOIN quadrant AS q ON e.quadrant_id = q.id
WHERE q.name = 'Southeast';