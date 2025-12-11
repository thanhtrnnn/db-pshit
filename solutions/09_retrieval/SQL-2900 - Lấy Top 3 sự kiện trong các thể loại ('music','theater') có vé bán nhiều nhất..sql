 -- Tables: events
 -- Technique: Filtering, Ordering, Limiting (dialect: Mysql)

 SELECT
  name,
  category,
  tickets_sold
 FROM
  events
 WHERE
  category IN ('music', 'theater')
 ORDER BY
  tickets_sold DESC
 LIMIT 3;