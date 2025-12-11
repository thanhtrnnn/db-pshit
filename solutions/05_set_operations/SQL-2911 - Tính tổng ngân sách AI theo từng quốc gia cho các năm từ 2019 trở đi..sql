-- Tables: ai_budget_usa, ai_budget_uk, ai_budget_japan
-- Technique: UNION ALL, GROUP BY, ORDER BY (dialect: Mysql)

SELECT
  country,
  SUM(budget) AS total_budget
FROM
  (
    SELECT
      country,
      budget,
      year
    FROM ai_budget_usa
    WHERE
      year >= 2019
    UNION ALL
    SELECT
      country,
      budget,
      year
    FROM ai_budget_uk
    WHERE
      year >= 2019
    UNION ALL
    SELECT
      country,
      budget,
      year
    FROM ai_budget_japan
    WHERE
      year >= 2019
  ) AS combined_budgets
GROUP BY
  country
ORDER BY
  total_budget DESC;