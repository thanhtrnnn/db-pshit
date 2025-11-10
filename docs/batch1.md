# LUYỆN TẬP TRUY VẤN SQL – PTIT VERSION
http://36.50.134.216:3000/

---

### 1. SQL94 - Consecutive number
```sql
SELECT DISTINCT L1.num AS ConsecutiveNums
FROM Logs L1
JOIN Logs L2 ON L1.id = L2.id - 1
JOIN Logs L3 ON L2.id = L3.id - 1
WHERE L1.num = L2.num AND L2.num = L3.num;
```

### 2. SQL95 - Big Countries
```sql
SELECT name, population, area
FROM World
WHERE area >= 3000000 OR population >= 25000000;
```

### 3. SQL96 - Replace Employee ID with unique identify (SQL Server)
```sql
SELECT U.unique_id, E.name
FROM Employees E
LEFT JOIN EmployeeUNI U ON E.id = U.id;
```

### 4. SQL97 - Average time of process per machine
```sql
SELECT machine_id,
    ROUND(
        SUM(CASE 
                WHEN activity_type = 'end' THEN timestamp
                ELSE -timestamp 
            END) 
        / COUNT(DISTINCT process_id), 
        3
    ) AS processing_time
FROM Activity
GROUP BY machine_id;
```

### 5. SQL98 - Delete duplicate emails
```sql
DELETE p1 
FROM Person p1
JOIN Person p2
WHERE p1.email = p2.email AND p1.id > p2.id;
```

### 6. SQL99 - Find custom referee
```sql
SELECT name
FROM Customer
WHERE referee_id != 2 OR referee_id IS NULL;
```

### 7. SQL100 - Recycle and low fat product
```sql
SELECT product_id
FROM Products
WHERE low_fats = 'Y' and recyclable = 'Y';
```

### 8. SQL101 - Not boring movie
```sql
SELECT * FROM Cinema
WHERE id % 2 = 1 AND description != "boring"
ORDER BY rating DESC;
```

### 9. SQL102 - Rising temperature
```sql
-- MySQL version
SELECT W1.id
FROM Weather W1
JOIN Weather W2 ON W1.recordDate = DATE_ADD(W2.recordDate, INTERVAL 1 DAY)
WHERE W1.temperature > W2.temperature;

-- SQL Server version note
-- (ON W1.recordDate = DATEADD(day, 1, W2.recordDate))
```

### 10. SQL103 - Liệt kê 2 khóa học theo tên giảng viên (sắp xếp theo tên giảm dần)
```sql
SELECT T.* 
FROM Teaches T
JOIN Class C ON T.dept = C.dept AND T.number = C.number
JOIN Instructor I ON T.username = I.username
ORDER BY I.lname DESC
LIMIT 2;
```

### 11. SQL104 - Tìm các lớp học đang được mở
```sql

```

### 12. SQL105 - Liệt kê 2 khóa học theo tên giảng viên (sắp xếp tăng dần)
```sql
SELECT I.username, T.dept, T.number, C.title
FROM Instructor I
JOIN Teaches T ON I.username = T.username
JOIN Class C ON T.dept = C.dept AND T.number = C.number
ORDER BY I.lname ASC
LIMIT 2;
```

### 13. SQL106 - Tìm firstname của Instructor
```sql
SELECT fname
FROM Instructor
WHERE username = "zahorjan";
```

### 14. SQL107 - Các khóa học cấp độ 400 (4xx) của CSE đang mở là gì
```sql
SELECT * FROM Class
WHERE dept = 'CSE' AND number BETWEEN 400 AND 499;
```

### 15. SQL108 - Tìm lớp học của thầy Levy
```sql
SELECT * FROM Teaches
WHERE username in ('djw', 'levy');
```

### 16. SQL109 - Quản lý product
```sql
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10, 2),
    stock_quantity INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 17. SQL110 - Những khóa học nào có tên bắt đầu bằng "Introduction"
```sql
SELECT * FROM Class
WHERE title LIKE 'Introduction%';
```

### 18. SQL111 - Sửa tiêu đề gõ sai
```sql
SELECT * FROM Class
WHERE LOWER(title) LIKE 'introduction%';
```

### 19. SQL112 - Hiển thị tên khóa học và độ dài của nó
```sql
SELECT title, LENGTH(title) AS length
FROM Class;
```

### 20. SQL113 - Chuẩn hóa tên các khóa học
```sql
SELECT dept, number, LEFT(title, 12) AS short_title
FROM Class;
```

### 21. SQL114 - Những instructors nào bắt đầu dạy trước 1990
```sql
SELECT * FROM Instructor
WHERE started_on < "1990-01-01"
ORDER BY username DESC;
```

### 22. SQL115 - Những instructors nào bắt đầu dạy trước thời điểm hiện tại
```sql
SELECT * FROM Instructor
WHERE DATE(started_on) < CURDATE();
```

### 23. SQL116 - Những instructors bắt đầu dạy vào hoặc sau ngày 1 tháng 1 của 20 năm trước
```sql
SELECT * FROM Instructor
WHERE
    started_on >= DATE_SUB(CURDATE(), INTERVAL 20 YEAR)
    AND DAY(started_on) = 1
    AND MONTH(started_on) = 1;
```

### 24. SQL117 - Sửa dữ liệu sai trong bảng
```sql
ALTER TABLE party_guests
MODIFY age INT,
MODIFY drinks_count INT;
```

### 25. SQL118 - Thiết kế cơ sở dữ liệu với bảng đăng ký khóa học
```sql
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
```

### 26. SQL119 - Chỉnh sửa bảng cơ sở dữ liệu với kiểu dữ liệu sai
```sql
ALTER TABLE Employees
MODIFY COLUMN employee_id INT;
```

### 27. SQL120 - Tạo procedure lấy danh sách nhân viên
```sql
CREATE PROCEDURE GetEmployeeById(IN employeeId INT)
BEGIN
    SELECT * FROM Employees WHERE id = employeeId;
END
```

### 28. SQL125 - Cập nhật kết quả sinh viên
```sql
UPDATE SinhVien
SET TrangThai = CASE
    WHEN DiemTB >= 5.0 THEN 'Đạt'
    ELSE 'Không đạt'
END;
```

### 29. SQL126 - Confirmation Rate
```sql
SELECT 
    s.user_id,
    ROUND(
        COALESCE(
            SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) / COUNT(c.user_id), 
            0
        ), 
        2
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id;
```

### 30. SQL127 - Number of Unique Subject taught by each teacher
```sql
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;
```

### 31. SQL128 - Class more than 5 student
```sql
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;
```

### 32. SQL129 - Invalid Tweets
```sql
SELECT tweet_id FROM Tweets
WHERE LENGTH(content) > 15;
```

### 33. SQL130 - Product Sales Analysis
```sql
SELECT p.product_name, s.year, s.price
FROM Sales s
JOIN Product p ON s.product_id = p.product_id;
```

### 34. SQL131 - Customer who bought all product
```sql
-- Solution using NOT EXISTS
SELECT customer_id FROM Customer c
WHERE NOT EXISTS (
    SELECT 1 FROM Product p
    WHERE NOT EXISTS (
        SELECT 1 FROM Customer c2
        WHERE c2.customer_id = c.customer_id AND c2.product_key = p.product_key
    )
);

-- Solution using GROUP BY and HAVING
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product);
```

### 35. SQL132 - Làm quen với LearnSQL
```sql
SELECT * FROM learnsql;
```

### 36. SQL133 - Average Selling Price
```sql
-- Solution 1
SELECT
    p.product_id,
    ROUND(SUM(u.units * p.price) / SUM(u.units), 2) AS average_price
FROM Prices p
LEFT JOIN UnitsSold u
    ON p.product_id = u.product_id
    AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;

-- Solution 2 (handles division by zero)
SELECT
    p.product_id,
    ROUND(
        SUM(p.price * IFNULL(u.units, 0)) / NULLIF(SUM(IFNULL(u.units, 0)), 0),
        2
    ) as average_price
FROM Prices p
LEFT JOIN UnitsSold u 
    ON p.product_id = u.product_id 
    AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;
```

### 37. SQL134 - Movie rating
```sql
(
    SELECT name AS results
    FROM Users u
    INNER JOIN MovieRating mr ON u.user_id = mr.user_id
    GROUP BY u.user_id, name
    ORDER BY COUNT(mr.user_id) DESC, name ASC
    LIMIT 1
)
UNION ALL
(
    SELECT title AS results
    FROM Movies m
    INNER JOIN MovieRating mr ON m.movie_id = mr.movie_id
    WHERE created_at >= '2020-02-01' AND created_at <= '2020-02-29'
    GROUP BY m.movie_id, title
    ORDER BY AVG(mr.rating) DESC, title ASC
    LIMIT 1
);
```

### 38. SQL136 - Students and examinations
```sql
SELECT 
    s.student_id, 
    s.student_name, 
    sub.subject_name,
    COUNT(e.student_id) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e 
    ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
```

### 39. SQL137 - Managers with at least 5 direction report
```sql
SELECT e1.name 
FROM Employee e1
JOIN Employee e2 ON e1.id = e2.managerId
GROUP BY e1.id, e1.name
HAVING COUNT(e2.id) >= 5;
```

### 40. SQL138 - Fix name in a table
```sql
-- MySQL version
UPDATE Users
SET name = CONCAT(UPPER(SUBSTRING(name, 1, 1)), LOWER(SUBSTRING(name, 2)))
ORDER BY user_id;

-- SQL Server version
UPDATE Users
SET name = UPPER(SUBSTRING(name, 1, 1)) + LOWER(SUBSTRING(name, 2, LEN(name) - 1));
```

### 41. SQL139 - Employee bonus
```sql
SELECT e.name, b.bonus
FROM Employee e
LEFT JOIN Bonus b ON e.empId = b.empId
WHERE b.bonus < 1000 OR b.bonus IS NULL;
```