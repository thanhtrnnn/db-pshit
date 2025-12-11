-- Tables: events
-- Technique: Group By, Filter (dialect: Mysql)

SELECT
  category,
  COUNT(id) AS event_count
FROM events
WHERE
  tickets_sold BETWEEN 100 AND 250
GROUP BY
  category
ORDER BY
  event_count DESC;