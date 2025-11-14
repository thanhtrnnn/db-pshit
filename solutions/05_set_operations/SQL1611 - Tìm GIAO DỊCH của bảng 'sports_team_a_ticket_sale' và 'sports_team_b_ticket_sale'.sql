SELECT sale_id, sale_date, quantity, price
FROM sports_team_a_ticket_sales
INTERSECT
SELECT sale_id, sale_date, quantity, price
FROM sports_team_b_ticket_sales;