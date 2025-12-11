-- Tables: companies, departments, employees
-- Technique: Group By, Joins (dialect: Mysql)
SELECT
    c.company_name,
    COALESCE(SUM(CASE WHEN e.gender = 'Female' THEN 1 ELSE 0 END) * 100.0 / COUNT(e.employee_id), 0) AS female_percentage,
    COALESCE(SUM(CASE WHEN e.gender = 'Male' THEN 1 ELSE 0 END) * 100.0 / COUNT(e.employee_id), 0) AS male_percentage
FROM
    companies c
JOIN
    departments d ON c.company_id = d.company_id
JOIN
    employees e ON d.dept_id = e.dept_id
GROUP BY
    c.company_id, c.company_name
ORDER BY
    c.company_name;