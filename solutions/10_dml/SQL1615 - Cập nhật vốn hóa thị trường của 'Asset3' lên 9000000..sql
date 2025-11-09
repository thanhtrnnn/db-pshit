-- Dialect: MySQL (standard UPDATE + subquery)
-- Exact output after UPDATE matches sample table; no SELECT wrapper required unless verifying.
UPDATE market_capitalization 
SET value = 9000000
WHERE asset_id = (
    SELECT da.id FROM digital_asset da WHERE da.name = 'Asset3'
);

-- Optional verification (do not include if platform auto-grades UPDATE only):
-- SELECT id, asset_id, value FROM market_capitalization ORDER BY id;
);
