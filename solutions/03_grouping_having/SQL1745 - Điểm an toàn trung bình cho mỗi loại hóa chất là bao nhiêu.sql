-- Tables: chemical_safety_scores
-- Technique: Group By (dialect: Mysql)

SELECT
  category,
  AVG(safety_score) AS average_safety_score
FROM chemical_safety_scores
GROUP BY
  category;