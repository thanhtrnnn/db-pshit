-- Tables: Exhibitions, Visitors
-- Technique: LEFT JOIN, UNION ALL, Aggregate (dialect: MySQL)
SELECT
    E.Name,
    COUNT(V.VisitorID) AS TotalVisitors
FROM
    Exhibitions AS E
LEFT JOIN
    Visitors AS V ON E.ExhibitionID = V.ExhibitionID
GROUP BY
    E.ExhibitionID, E.Name;