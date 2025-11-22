--- Tables: crypto_exchanges
--- Technique: UPDATE (dialect: Mysql)
UPDATE crypto_exchanges
SET regulatory_status = 'Được cấp phép'
WHERE exchange_name = 'Coinbase';