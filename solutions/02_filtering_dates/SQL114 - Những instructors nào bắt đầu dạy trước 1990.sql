-- Imported from batch1.md
-- Title: Những instructors nào bắt đầu dạy trước 1990

SELECT * FROM Instructor
WHERE started_on < "1990-01-01"
ORDER BY username DESC;
