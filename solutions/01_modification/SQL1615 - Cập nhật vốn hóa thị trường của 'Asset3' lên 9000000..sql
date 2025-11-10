--- Tables: digital_asset, market_capitalization
--- Technique: modification (dialect: Sql Server)

UPDATE mc
SET value = 9000000
FROM market_capitalization mc
JOIN digital_asset da ON mc.asset_id = da.id
WHERE da.name = 'Asset3';