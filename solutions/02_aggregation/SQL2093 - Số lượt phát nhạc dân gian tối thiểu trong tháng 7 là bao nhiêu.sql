 -- Tables: Streams
 -- Technique: Filtering, Aggregation (dialect: Mysql)
 SELECT
  MIN(streams) AS `MIN(streams)`
 FROM
  Streams
 WHERE
  genre = 'dân gian' AND MONTH(date) = 7;