 -- Tables: Painting, Drawing
 -- Technique: Subquery (dialect: Mysql)

SELECT ABS((SELECT COUNT(*) FROM Painting) - (SELECT COUNT(*) FROM Drawing)) AS `COUNT(*)`;