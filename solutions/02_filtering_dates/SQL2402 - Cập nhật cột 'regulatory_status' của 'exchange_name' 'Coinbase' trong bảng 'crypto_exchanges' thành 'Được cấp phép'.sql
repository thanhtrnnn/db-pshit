-- Problem: SQL2402 - Cập nhật cột 'regulatory_status' của 'exchange_name' 'Coinbase' trong bảng 'crypto_exchanges' thành 'Được cấp phép'.html
-- Auto-classified section: 02_filtering_dates
-- Rationale: Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.
-- Adjust table/column names before running.

-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
