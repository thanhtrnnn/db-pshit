-- Tables: ai_budget_usa, ai_budget_uk, ai_budget_japan
-- Technique: UNION ALL, Aggregate Function (dialect: Mysql)

SELECT
  AVG(budget) AS num_budget
FROM (
  SELECT
    budget,
    year
  FROM ai_budget_usa
  WHERE
    year BETWEEN 2018 AND 2020
  UNION ALL
  SELECT
    budget,
    year
  FROM ai_budget_uk
  WHERE
    year BETWEEN 2018 AND 2020
  UNION ALL
  SELECT
    budget,
    year
  FROM ai_budget_japan
  WHERE
    year BETWEEN 2018 AND 2020
) AS combined_budgets;