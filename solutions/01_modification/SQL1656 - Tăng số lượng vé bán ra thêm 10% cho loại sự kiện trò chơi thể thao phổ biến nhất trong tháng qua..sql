-- Tables: TicketSales
-- Technique: Modification (dialect: Sql Server)

UPDATE TicketSales
SET tickets_sold = CAST(tickets_sold * 1.10 AS INT)
WHERE event_type = 'Sports Game'
  AND date >= DATEADD(month, DATEDIFF(month, 0, GETDATE()) - 1, 0)
  AND date < DATEADD(month, DATEDIFF(month, 0, GETDATE()), 0)
  AND 'Sports Game' = (
    SELECT TOP 1 T.event_type
    FROM TicketSales AS T
    WHERE T.date >= DATEADD(month, DATEDIFF(month, 0, GETDATE()) - 1, 0)
      AND T.date < DATEADD(month, DATEDIFF(month, 0, GETDATE()), 0)
    GROUP BY T.event_type
    ORDER BY SUM(T.tickets_sold) DESC
  );