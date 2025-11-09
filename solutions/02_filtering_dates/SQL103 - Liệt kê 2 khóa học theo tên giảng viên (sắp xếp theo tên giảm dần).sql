-- Imported from batch1.md
-- Title: Liệt kê 2 khóa học theo tên giảng viên (sắp xếp theo tên giảm dần)

SELECT T.*
FROM Teaches T
JOIN Class C ON T.dept = C.dept AND T.number = C.number
JOIN Instructor I ON T.username = I.username
ORDER BY I.lname DESC
LIMIT 2;
