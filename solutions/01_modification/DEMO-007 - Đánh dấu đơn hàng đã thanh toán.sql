 -- Tables: ORDER, PAYMENT
 -- Technique: UPDATE (dialect: Mysql)

 UPDATE `ORDER` o
 JOIN (
     SELECT DISTINCT OrderID
     FROM PAYMENT
     WHERE Status = 'PAID'
 ) AS p_paid ON o.OrderID = p_paid.OrderID
 SET o.Status = 'PAID';