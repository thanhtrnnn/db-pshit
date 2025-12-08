-- Tables: EMPLOYEE, SALEORDER
-- Technique: UPDATE with JOIN (dialect: Mysql)

UPDATE EMPLOYEE e
JOIN (
    SELECT
        EmpID
    FROM
        SALEORDER
    WHERE
        Status = 'COMPLETED'
    GROUP BY
        EmpID
    HAVING
        SUM(TotalAmount) > 50000
) AS sales_summary ON e.EmpID = sales_summary.EmpID
SET
    e.Salary = e.Salary * 1.10;