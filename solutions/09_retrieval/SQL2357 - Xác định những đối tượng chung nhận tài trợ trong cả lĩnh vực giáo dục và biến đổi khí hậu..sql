--- Tables: Grants
--- Technique: Self-join (dialect: MySQL)

SELECT DISTINCT g1.Recipient
FROM Grants g1
JOIN Grants g2 ON g1.Recipient = g2.Recipient
WHERE g1.Field = 'Education' AND g2.Field = 'Climate Change';