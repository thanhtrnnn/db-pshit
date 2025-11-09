-- Yêu cầu: Liệt kê các khóa học đang được giảng dạy (mở lớp) cùng tiêu đề.
-- Giả định: Một lớp "đang mở" nếu tồn tại dòng trong Teaches trùng dept+number.
-- Output: title duy nhất.
SELECT DISTINCT c.title
FROM Class c
JOIN Teaches t ON t.dept = c.dept AND t.number = c.number
ORDER BY c.title;
