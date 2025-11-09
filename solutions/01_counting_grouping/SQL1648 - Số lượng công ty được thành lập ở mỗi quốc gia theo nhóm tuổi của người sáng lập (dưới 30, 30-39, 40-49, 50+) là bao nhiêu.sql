-- SQL1648: Số lượng công ty theo quốc gia và nhóm tuổi của nhà sáng lập
-- Bảng: founders(founder_id, company_id, age), companies(company_id, founding_year, country), age_groups(age, age_group)
-- Yêu cầu: Đếm số công ty được thành lập ở mỗi quốc gia theo nhóm tuổi của người sáng lập.
-- Output: country | age_group | num_companies_founded
-- Ghi chú: Mapping tuổi sang nhóm bằng join với age_groups (tuổi chính xác khớp mốc; ví dụ 28 không xuất hiện trong age_groups sample => cần CASE hoặc range thực tế; với sample dùng ngưỡng, ta áp dụng CASE).

SELECT c.country,
       CASE
           WHEN f.age < 30 THEN 'Under 30'
           WHEN f.age BETWEEN 30 AND 39 THEN '30-39'
           WHEN f.age BETWEEN 40 AND 49 THEN '40-49'
           ELSE '50+'
       END AS age_group,
       COUNT(DISTINCT c.company_id) AS num_companies_founded
FROM founders f
JOIN companies c ON c.company_id = f.company_id
GROUP BY c.country,
         CASE
           WHEN f.age < 30 THEN 'Under 30'
           WHEN f.age BETWEEN 30 AND 39 THEN '30-39'
           WHEN f.age BETWEEN 40 AND 49 THEN '40-49'
           ELSE '50+'
         END
ORDER BY c.country, age_group;

