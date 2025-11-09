-- Imported from batch1.md
-- Title: Những instructors bắt đầu dạy vào hoặc sau ngày 1 tháng 1 của 20 năm trước

SELECT * FROM Instructor
WHERE
    started_on >= DATE_SUB(CURDATE(), INTERVAL 20 YEAR)
    AND DAY(started_on) = 1
    AND MONTH(started_on) = 1;
