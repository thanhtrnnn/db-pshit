SET SQL_SAFE_UPDATES = 0;
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
SET SQL_SAFE_UPDATES = 1;