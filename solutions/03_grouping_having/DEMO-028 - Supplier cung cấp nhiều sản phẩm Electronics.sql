 -- Tables: Category, Product, Supplier, Supply
 -- Technique: JOIN, GROUP BY, HAVING (dialect: Mysql)
SELECT
  s.SID,
  s.SName
FROM
  Supplier AS s
JOIN Supply AS sy ON s.SID = sy.SID
JOIN Product AS p ON sy.PID = p.PID
JOIN Category AS c ON p.CatID = c.CatID
WHERE
  c.CatName = 'Electronics'
GROUP BY
  s.SID,
  s.SName
HAVING
  COUNT(DISTINCT p.PID) >= 2;