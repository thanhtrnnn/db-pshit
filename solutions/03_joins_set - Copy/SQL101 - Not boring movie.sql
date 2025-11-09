-- Imported from batch1.md
-- Title: Not boring movie

SELECT * FROM Cinema
WHERE id % 2 = 1 AND description != "boring"
ORDER BY rating DESC;
