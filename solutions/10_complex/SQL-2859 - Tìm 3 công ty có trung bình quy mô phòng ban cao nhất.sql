-- Tables: companies, departments, employees
-- Technique: Common Table Expressions (CTE) and Window Functions (dialect: mysql)

WITH DeptEmployeeCount AS (
    SELECT
        d.company_id,
        d.dept_id,
        COUNT(e.employee_id) AS employee_count,
        SUM(CASE WHEN e.gender = 'Female' THEN 1 ELSE 0 END) AS female_employee_count
    FROM departments AS d
    JOIN employees AS e
        ON d.dept_id = e.dept_id
    GROUP BY
        d.company_id,
        d.dept_id
    HAVING
        COUNT(e.employee_id) >= 2
),
CompanyDeptAverages AS (
    SELECT
        c.company_id,
        c.company_name,
        AVG(de.employee_count) AS avg_dept_size,
        SUM(de.female_employee_count) AS total_female_employees,
        SUM(de.employee_count) AS total_employees_in_qualified_depts,
        COUNT(de.dept_id) AS qualified_dept_count
    FROM companies AS c
    JOIN DeptEmployeeCount AS de
        ON c.company_id = de.company_id
    GROUP BY
        c.company_id,
        c.company_name
    HAVING
        qualified_dept_count >= 2
)
SELECT
    cda.company_name,
    cda.avg_dept_size,
    CASE
        WHEN cda.total_employees_in_qualified_depts > 0 THEN ROUND((cda.total_female_employees * 100.0 / cda.total_employees_in_qualified_depts), 0)
        ELSE 0
    END AS female_percentage
FROM CompanyDeptAverages AS cda
ORDER BY
    cda.avg_dept_size DESC,
    female_percentage DESC
LIMIT 3;