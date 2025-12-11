-- Tables: companies, departments, employees
-- Technique: JOIN (dialect: mysql)

SELECT
    c.company_name,
    d.dept_name,
    (SUM(CASE WHEN e.gender = 'Female' THEN 1 ELSE 0 END) * 100.0 / COUNT(e.employee_id)) AS female_percentage
FROM
    departments AS d
JOIN
    employees AS e ON d.dept_id = e.dept_id
JOIN
    companies AS c ON d.company_id = c.company_id
GROUP BY
    d.dept_id, c.company_name, d.dept_name
HAVING
    (SUM(CASE WHEN e.gender = 'Female' THEN 1 ELSE 0 END) * 100.0 / COUNT(e.employee_id)) >= 60
ORDER BY
    female_percentage DESC,
    d.dept_name ASC;