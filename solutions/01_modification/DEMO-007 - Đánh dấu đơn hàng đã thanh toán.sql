 -- Tables: ORDER, PAYMENT
 -- Technique: UPDATE (dialect: Mysql)

UPDATE SALEORDER o
JOIN (
    SELECT DISTINCT OrderID
    FROM PAYMENT
    WHERE Status = 'PAID'
) AS p_paid ON o.OrderID = p_paid.OrderID
SET o.Status = 'PAID';

-- subquery
UPDATE SALEORDER o
SET o.Status = 'PAID'
WHERE o.OrderID IN (
    SELECT DISTINCT OrderID
    FROM PAYMENT
    WHERE Status = 'PAID'
);