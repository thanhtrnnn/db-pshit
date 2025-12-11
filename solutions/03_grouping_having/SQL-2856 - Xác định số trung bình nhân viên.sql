-- Tables: companies, departments, employees
-- Technique: JOIN, GROUP BY, ORDER BY, LIMIT

SELECT
    c.company_name,
    ROUND(CAST(COUNT(e.employee_id) AS DECIMAL) / COUNT(DISTINCT d.dept_id), 2) AS avg_employees_per_department
FROM
    companies AS c
JOIN
    departments AS d ON c.company_id = d.company_id
LEFT JOIN
    employees AS e ON d.dept_id = e.dept_id
GROUP BY
    c.company_name
ORDER BY
    avg_employees_per_department DESC
LIMIT 3;