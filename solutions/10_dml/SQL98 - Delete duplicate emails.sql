-- Imported from batch1.md
-- Title: Delete duplicate emails

DELETE p1
FROM Person p1
JOIN Person p2
WHERE p1.email = p2.email AND p1.id > p2.id;
