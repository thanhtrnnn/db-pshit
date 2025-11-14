-- Tables: digital_asset, market_capitalization
-- Technique: modification (dialect: Sql Server)

UPDATE market_capitalization
SET value = 9000000
WHERE asset_id = (SELECT id FROM digital_asset WHERE name = 'Asset3');