-- Tables: investments, investors, organizations
-- Technique: Joins, Aggregation, Filtering, Ordering (dialect: Mysql)

SELECT
  i.investor_name,
  SUM(inv.investment_amount) AS total_invested
FROM investments AS inv
JOIN investors AS i
  ON inv.investor_id = i.investor_id
JOIN organizations AS o
  ON inv.org_id = o.org_id
WHERE
  o.focus_topic = 'Education'
GROUP BY
  i.investor_name
ORDER BY
  total_invested DESC
LIMIT 2;