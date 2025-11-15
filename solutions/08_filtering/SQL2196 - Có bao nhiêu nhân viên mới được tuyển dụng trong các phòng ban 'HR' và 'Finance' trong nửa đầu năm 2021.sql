 -- Tables: Talent_Acquisition
 -- Technique: Filtering, Grouping (dialect: Mysql)
 
 SELECT
  Department,
  COUNT(*) AS `COUNT(*)`
 FROM
  Talent_Acquisition
 WHERE
  Department IN ('HR', 'Finance')
  AND Hire_Date BETWEEN '2021-01-01' AND '2021-06-30'
 GROUP BY
  Department;
 