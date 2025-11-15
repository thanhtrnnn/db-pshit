 -- Tables: DefenseProjects, ContractorsProjects, Contractors
 -- Technique: Joins, Subquery (dialect: Mysql)

 SELECT
  c.ContractorID AS `Mã nhà thầu`,
  c.ContractorName AS `Tên nhà thầu`,
  dp.ProjectID AS `Mã dự án`,
  dp.ProjectName AS `Tên dự án`,
  DATEDIFF(dp.EndDate, dp.StartDate) AS `Thời hạn dự án`
 FROM
  Contractors c
  JOIN ContractorsProjects cp ON c.ContractorID = cp.ContractorID
  JOIN DefenseProjects dp ON cp.ProjectID = dp.ProjectID
 WHERE
  DATEDIFF(dp.EndDate, dp.StartDate) = (
    SELECT
        MAX(DATEDIFF(EndDate, StartDate))
    FROM DefenseProjects
    )
 ORDER BY
  c.ContractorID,
  dp.ProjectID;
 