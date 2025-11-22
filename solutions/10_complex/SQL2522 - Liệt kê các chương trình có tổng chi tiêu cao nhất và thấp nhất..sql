WITH ProgramExpenses AS (
    SELECT
        p.name,
        SUM(d.amount) AS total_expenses
    FROM
        programs p
    JOIN
        donations d ON p.id = d.program_id
    GROUP BY
        p.id, p.name
)
SELECT
    name,
    total_expenses
FROM
    ProgramExpenses
WHERE
    total_expenses = (SELECT MAX(total_expenses) FROM ProgramExpenses)
    OR total_expenses = (SELECT MIN(total_expenses) FROM ProgramExpenses);