 -- Tables: events
 -- Technique: Aggregation (dialect: Mysql)
 SELECT
  SUM(tickets_sold) AS num_tickets_sold
 FROM
  events
 WHERE
  category IN ('music', 'theater');