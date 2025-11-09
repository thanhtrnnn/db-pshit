-- Imported from batch1.md
-- Title: Replace Employee ID with unique identify (SQL Server)

SELECT U.unique_id, E.name
FROM Employees E
LEFT JOIN EmployeeUNI U ON E.id = U.id;
