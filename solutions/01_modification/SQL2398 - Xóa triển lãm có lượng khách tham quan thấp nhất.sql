DELETE FROM exhibitions
WHERE visitor_count = (
    SELECT MIN(visitor_count)
    FROM exhibitions
);