-- SQL1663: Chi phí R&D của một thuốc so với trung bình các thuốc khác cùng năm
-- Bảng: r_and_d_data(drug_name, expenditure, year)
-- Output: expenditure (giá trị của thuốc mục tiêu - sample hiển thị giá trị trực tiếp DrugA 500000)
-- Giả định: Thuốc cụ thể và năm được truyền (ví dụ DrugA, 2020); nếu cần tham số hóa dùng placeholders.

SELECT expenditure
FROM r_and_d_data
WHERE drug_name = 'DrugA'
  AND year = '2020';

-- Nếu cần so sánh (chênh lệch so với trung bình các thuốc khác):
-- SELECT r.expenditure - avg_others.avg_expenditure AS diff_from_avg
-- FROM r_and_d_data r
-- JOIN (
--   SELECT year, AVG(expenditure) AS avg_expenditure
--   FROM r_and_d_data
--   WHERE year = '2020' AND drug_name <> 'DrugA'
-- ) avg_others ON avg_others.year = r.year
-- WHERE r.drug_name = 'DrugA' AND r.year = '2020';
-- Problem: SQL1663 - Chi phí R&D cho một loại thuốc cụ thể trong một năm nhất định là bao nhiêu so với chi tiêu R&D trung bình cho các loại thuốc khác trong cùng năm đó.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
