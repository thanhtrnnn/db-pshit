SELECT
  country,
  COUNT(DISTINCT asset_name) AS total_unique_managed_assets
FROM digital_assets
WHERE
  regulatory_status = 'được quản lý'
GROUP BY
  country;
