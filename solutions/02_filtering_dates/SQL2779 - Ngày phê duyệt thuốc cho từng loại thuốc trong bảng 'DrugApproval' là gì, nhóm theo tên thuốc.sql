-- Problem: SQL2779 - Ngày phê duyệt thuốc cho từng loại thuốc trong bảng 'DrugApproval' là gì, nhóm theo tên thuốc.html
-- Auto-classified section: 02_filtering_dates
-- Rationale: Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.
-- Adjust table/column names before running.

-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
