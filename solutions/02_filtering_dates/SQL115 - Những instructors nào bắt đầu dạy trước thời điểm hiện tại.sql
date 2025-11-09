-- Imported from batch1.md
-- Title: Những instructors nào bắt đầu dạy trước thời điểm hiện tại

SELECT * FROM Instructor
WHERE DATE(started_on) < CURDATE();
