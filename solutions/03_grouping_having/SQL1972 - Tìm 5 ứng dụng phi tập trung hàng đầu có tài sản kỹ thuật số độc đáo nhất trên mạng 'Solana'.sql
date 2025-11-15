-- Tables: decentralized_applications, app_assets
-- Technique: Group By, Order By, Limit (dialect: MySQL)
SELECT
  da.app_name,
  COUNT(DISTINCT aa.asset_id) AS unique_asset_count
FROM
  decentralized_applications AS da
JOIN
  app_assets AS aa
ON
  da.app_id = aa.app_id
WHERE
  da.network = 'Solana'
GROUP BY
  da.app_name
ORDER BY
  unique_asset_count DESC
LIMIT 5;