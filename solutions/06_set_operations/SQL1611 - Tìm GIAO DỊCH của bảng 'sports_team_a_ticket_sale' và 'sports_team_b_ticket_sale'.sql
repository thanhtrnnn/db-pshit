 -- Tables: sports_team_a_ticket_sales, sports_team_b_ticket_sales
 -- Technique: set_operations (dialect: Sql Server)

 SELECT
  sale_id,
  sale_date,
  quantity,
  price
 FROM
  sports_team_a_ticket_sales

 UNION ALL

 SELECT
  sale_id,
  sale_date,
  quantity,
  price
 FROM
  sports_team_b_ticket_sales;
