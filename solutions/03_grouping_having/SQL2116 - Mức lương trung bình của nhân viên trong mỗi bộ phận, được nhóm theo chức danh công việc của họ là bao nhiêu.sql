 -- Tables: Employees
 -- Technique: Group By (dialect: Mysql)
 
 SELECT
  Department,
  JobTitle,
  AVG(Salary) AS AvgSalary
 FROM
  Employees
 GROUP BY
  Department,
  JobTitle
 ORDER BY
  Department,
  JobTitle;