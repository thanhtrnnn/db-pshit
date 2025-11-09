-- SQL1656: Tăng tickets_sold thêm 10% cho 'Sports Game' phổ biến nhất trong tháng qua
-- Bảng: TicketSales(id, event_type, location, tickets_sold, price, ticket_type, date)
-- Định nghĩa 'tháng qua': CURRENT_DATE - INTERVAL 30 DAY (đơn giản hóa). Nếu cần theo tháng lịch, điều chỉnh.

UPDATE TicketSales ts
JOIN (
    SELECT location
    FROM TicketSales
    WHERE event_type = 'Sports Game'
      AND date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
    GROUP BY location
    ORDER BY SUM(tickets_sold) DESC
    LIMIT 1
) popular USING (location)
SET ts.tickets_sold = CAST(ROUND(ts.tickets_sold * 1.10) AS SIGNED)
WHERE ts.event_type = 'Sports Game'
  AND ts.date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY);
