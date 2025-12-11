-- Tables: ai_budget_usa, ai_budget_uk, ai_budget_japan
-- Technique: UNION ALL, GROUP BY, ORDER BY (dialect: Mysql)

SELECT
  year,
  SUM(budget) AS total_budget
FROM
  (
    SELECT
      budget,
      year
    FROM
      ai_budget_usa
    WHERE
      year BETWEEN 2018 AND 2021
    UNION ALL
    SELECT
      budget,
      year
    FROM
      ai_budget_uk
    WHERE
      year BETWEEN 2018 AND 2021
    UNION ALL
    SELECT
      budget,
      year
    FROM
      ai_budget_japan
    WHERE
      year BETWEEN 2018 AND 2021
  ) AS combined_budgets
GROUP BY
  year
ORDER BY
  total_budget DESC
LIMIT 1;