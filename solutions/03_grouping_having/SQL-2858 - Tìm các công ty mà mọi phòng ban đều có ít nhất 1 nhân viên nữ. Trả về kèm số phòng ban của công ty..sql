SELECT 
    c.company_name,
    COUNT(DISTINCT d.dept_id) AS dept_count
FROM 
    companies c
JOIN 
    departments d ON c.company_id = d.company_id
LEFT JOIN 
    employees e ON d.dept_id = e.dept_id AND e.gender = 'Female'
GROUP BY 
    c.company_id, c.company_name
HAVING 
    COUNT(DISTINCT d.dept_id) = COUNT(DISTINCT CASE WHEN e.employee_id IS NOT NULL THEN d.dept_id ELSE NULL END);