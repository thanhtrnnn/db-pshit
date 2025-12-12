UPDATE Payment
SET
  Status = 'PAID',
  PaidAt = '2025-01-01'
WHERE
  OrderID IN (
    SELECT
      oi.OrderID
    FROM
      OrderItem AS oi
      JOIN Product AS p ON oi.PID = p.PID
    GROUP BY
      oi.OrderID
    HAVING
      SUM(oi.Qty * p.Price) >= 500
  );

-- subquery
Update Payment
Set Status = 'PAID', PaidAt = '2025-01-01'
Where OrderID in (
    Select o.OrderID
    From OrderItem o 
    Join Product p on p.PID = o.PID
    Group by o.OrderID
    Having sum(p.Price * o.Qty) >= 500
);