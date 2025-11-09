-- Imported from batch1.md
-- Title: Fix name in a table

-- MySQL version
UPDATE Users
SET name = CONCAT(UPPER(SUBSTRING(name, 1, 1)), LOWER(SUBSTRING(name, 2)))
ORDER BY user_id;

-- SQL Server version
UPDATE Users
SET name = UPPER(SUBSTRING(name, 1, 1)) + LOWER(SUBSTRING(name, 2, LEN(name) - 1));
