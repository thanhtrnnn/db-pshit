 -- Tables: Menu_Categories, Menu_Items, Inspections
 -- Technique: JOIN, GROUP BY (dialect: Mysql)

 SELECT
  mc.Category_Name AS `Tên loại thực đơn`,
  SUM(i.Violation_Count) AS `Tổng số vụ vi phạm`
 FROM
  Menu_Categories AS mc
 JOIN
  Menu_Items AS mi
  ON mc.Category_ID = mi.Category_ID
 JOIN
  Inspections AS i
  ON mi.Item_ID = i.Item_ID
 GROUP BY
  mc.Category_Name;
