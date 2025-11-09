-- Problem: SQL2454 - Liệt kê tất cả các loại xe được trưng bày tại Triển lãm ô tô Paris và xếp hạng an toàn của chúng..html
-- Auto-classified section: 02_filtering_dates
-- Rationale: Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.
-- Adjust table/column names before running.

-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
