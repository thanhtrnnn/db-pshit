-- Tables: research, gene
-- Technique: Group By, Order By, Limit (dialect: Mysql)

SELECT
    r.title,
    COUNT(g.id) AS gene_count
FROM
    research AS r
JOIN
    gene AS g
ON
    r.id = g.research_id
GROUP BY
    r.title
ORDER BY
    gene_count DESC,
    r.title ASC
LIMIT 3;