-- Imported from batch1.md
-- Title: Chuẩn hóa tên các khóa học

SELECT dept, number, LEFT(title, 12) AS short_title
FROM Class;
