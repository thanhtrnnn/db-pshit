 -- Tables: Customer
 -- Technique: Retrieval (dialect: Mysql)
 SELECT *
 FROM
  Customer
 WHERE
  City = 'London' AND CustomerID % 2 = 0
 ORDER BY
  CustomerID;