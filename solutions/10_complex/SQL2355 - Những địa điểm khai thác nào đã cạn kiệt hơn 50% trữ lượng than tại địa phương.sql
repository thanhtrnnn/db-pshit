 -- Tables: mining_sites, coal_reserves
 -- Technique: CTE, JOIN (dialect: Mysql)
 WITH LatestReserves AS (
  SELECT
   site_id,
   coal_reserve_remaining,
   ROW_NUMBER() OVER (PARTITION BY site_id ORDER BY update_date DESC) AS rn
  FROM
   coal_reserves
 )
 SELECT
  ms.name
 FROM
  mining_sites ms
  JOIN LatestReserves lr ON ms.id = lr.site_id
 WHERE
  lr.rn = 1
  AND lr.coal_reserve_remaining < ms.coal_reserve_initial * 0.5;