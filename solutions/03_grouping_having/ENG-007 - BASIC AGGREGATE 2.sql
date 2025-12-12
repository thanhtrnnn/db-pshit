 -- Tables: Employee
 -- Technique: GROUP BY, HAVING, aggregation (dialect: Mysql)

SELECT
  Dept,
  COUNT(DISTINCT EmpID) AS EmployeeCount,
  AVG(Salary) AS AvgSalary
FROM
  Employee
GROUP BY
  Dept
HAVING
  AvgSalary > 2000;