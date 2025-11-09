# SQL Recipes and Solution Approaches for problems/ folder

This guide gives practical solution patterns (with ready-to-use SQL templates) that cover the vast majority of tasks in `problems/`. Use the pattern that matches each problem’s verb and data shape (count/list/top-N/update/delete/insert/compare, etc.). All examples are standard SQL; MySQL-specific notes are added when useful.

Tip: Adjust table/column names to your schema and replace literals. For MySQL date math, use DATEDIFF/DATE_ADD; for Postgres, use INTERVALs.

## 1) Counting and grouping

- Count per group
```sql
SELECT region, COUNT(*) AS cnt
FROM facilities
GROUP BY region
ORDER BY region;
```

- Count with condition per group
```sql
SELECT country,
       SUM(CASE WHEN type = 'hospital' THEN 1 ELSE 0 END) AS hospitals,
       SUM(CASE WHEN type = 'clinic'   THEN 1 ELSE 0 END) AS clinics
FROM health_facilities
GROUP BY country;
```

- Count distinct
```sql
SELECT teacher_id, COUNT(DISTINCT subject) AS unique_subjects
FROM teacher_subjects
GROUP BY teacher_id;
```

## 2) Filtering by attributes and date/time

- Basic filters
```sql
SELECT name, rating
FROM movies
WHERE country = 'Brazil' AND rating >= 8;
```

- Date window (last N days)
```sql
-- MySQL
SELECT *
FROM events
WHERE event_date >= CURDATE() - INTERVAL 7 DAY;
```

- Day-to-day comparison (rising temperature)
```sql
-- MySQL: DATEDIFF(d2, d1) = 1
SELECT w1.id
FROM weather w1
JOIN weather w2
  ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
 AND w1.city = w2.city
WHERE w1.temperature > w2.temperature;
```

## 3) Joins: inner, left anti-join, semi-join

- Inner join
```sql
SELECT o.id, c.name, o.amount
FROM orders o
JOIN customers c ON c.id = o.customer_id;
```

- Left anti-join ("in A but not in B")
```sql
SELECT a.*
FROM table_a a
LEFT JOIN table_b b ON b.a_id = a.id
WHERE b.a_id IS NULL;
```

- Intersection ("in both A and B")
```sql
SELECT user_id
FROM (
  SELECT user_id, 'A' AS grp FROM actions WHERE category = 'A'
  UNION ALL
  SELECT user_id, 'B' FROM actions WHERE category = 'B'
) t
GROUP BY user_id
HAVING COUNT(DISTINCT grp) = 2;
```

## 4) Top-N per group (window functions)

```sql
SELECT *
FROM (
  SELECT country, project, budget,
         ROW_NUMBER() OVER (PARTITION BY country ORDER BY budget DESC) AS rn
  FROM projects
) t
WHERE rn <= 3
ORDER BY country, rn;
```

## 5) Aggregations with conditional pivots

```sql
SELECT category,
       SUM(CASE WHEN season = 'Spring' THEN amount ELSE 0 END) AS spring_amt,
       SUM(CASE WHEN season = 'Summer' THEN amount ELSE 0 END) AS summer_amt,
       SUM(CASE WHEN season = 'Fall'   THEN amount ELSE 0 END) AS fall_amt,
       SUM(CASE WHEN season = 'Winter' THEN amount ELSE 0 END) AS winter_amt
FROM sales
GROUP BY category;
```

## 6) Division queries ("bought all products")

```sql
SELECT c.customer_id
FROM customers c
JOIN purchases p ON p.customer_id = c.customer_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT p.product_id) = (
  SELECT COUNT(DISTINCT product_id) FROM products
);
```

## 7) Range joins (effective dates)

```sql
SELECT p.product_id,
       ROUND(SUM(p2.price * u.quantity) / NULLIF(SUM(u.quantity), 0), 2) AS avg_price
FROM UnitsSold u
JOIN Prices p2
  ON p2.product_id = u.product_id
 AND u.purchase_date BETWEEN p2.start_date AND p2.end_date
JOIN Products p ON p.product_id = u.product_id
GROUP BY p.product_id;
```

## 8) Set differences and symmetric logic

- "either A or B but not both"
```sql
SELECT user_id
FROM (
  SELECT user_id, SUM(CASE WHEN cond_a THEN 1 ELSE 0 END) AS a,
                 SUM(CASE WHEN cond_b THEN 1 ELSE 0 END) AS b
  FROM events
  GROUP BY user_id
) t
WHERE (a > 0 OR b > 0) AND NOT (a > 0 AND b > 0);
```

## 9) Window-based sequences (consecutive rows)

```sql
SELECT DISTINCT num
FROM (
  SELECT num,
         LAG(num, 1) OVER (ORDER BY id) AS n1,
         LAG(num, 2) OVER (ORDER BY id) AS n2
  FROM logs
) t
WHERE num = n1 AND num = n2;
```

## 10) DML: INSERT / UPDATE / DELETE

- Insert
```sql
INSERT INTO volunteers (id, name, hours_served)
VALUES (5, 'Liam Brown', 30.00);
```

- Update with arithmetic
```sql
UPDATE employees
SET salary = ROUND(salary * 1.10, 2)
WHERE status = 'active';
```

- Delete by condition
```sql
DELETE FROM shipments
WHERE origin_warehouse = 'Rio de Janeiro'
  AND destination_country = 'Brazil'
  AND ship_date < '2022-02-01';
```

- Update via join
```sql
-- MySQL syntax
UPDATE contracts c
JOIN owners o ON o.owner_id = c.owner_id
SET c.address = o.address
WHERE c.address IS NULL;
```

## 11) String cleaning and normalization

```sql
SELECT id,
       CONCAT(UPPER(LEFT(name,1)), LOWER(SUBSTRING(name,2))) AS fixed_name
FROM people;
```

## 12) Frequently asked patterns mapped to your file names

Below are pattern pairings you can apply directly to matching problem names in `problems/`.

- "Tổng số / Số lượng / Có bao nhiêu ..." → Counting and grouping (Sections 1, 2, 3)
- "Liệt kê / Hiển thị / Kể tên ..." → Filtering + joins; optional ORDER BY; distinct if needed
- "So sánh ..." → Grouped sums for regions, then compare or use window rank
- "Top N ..." → Window functions (Section 4)
- "Xác định ... đã ở cả A và B" → Intersection (Section 3)
- "... nhưng không ..." → Left anti-join (Section 3)
- "Cập nhật ..." → DML UPDATE (Section 10)
- "Xóa ..." → DML DELETE (Section 10)
- "Chèn ..." → DML INSERT (Section 10)
- "Trung bình / Tỷ lệ / Tỷ lệ phần trăm" → Aggregation + CASE; AVG of indicator
- "Trong quý / năm / tháng ..." → Date filtering (Section 2)
- "theo quốc gia / khu vực" → GROUP BY country/region; sometimes need a join to a geography table

## 13) Concrete solutions for common classics (adjust table names)

- Big Countries (SQL95)
```sql
SELECT name, population, area
FROM World
WHERE area >= 3000000 OR population >= 25000000;
```

- Delete Duplicate Emails (SQL98)
```sql
DELETE p1
FROM Person p1
JOIN Person p2
  ON p1.Email = p2.Email AND p1.Id > p2.Id;
```

- Consecutive Numbers (SQL94)
```sql
SELECT DISTINCT num AS ConsecutiveNums
FROM (
  SELECT id, num,
         LAG(num, 1) OVER (ORDER BY id) AS n1,
         LAG(num, 2) OVER (ORDER BY id) AS n2
  FROM Logs
) t
WHERE num = n1 AND num = n2;
```

- Replace Employee ID with Unique Identifier (SQL96)
```sql
SELECT u.unique_id, e.name
FROM Employees e
LEFT JOIN EmployeeUNI u ON u.id = e.id;
```

- Average Time of Process per Machine (SQL97)
```sql
WITH pairs AS (
  SELECT machine_id, process_id,
         MAX(CASE WHEN activity_type = 'start' THEN timestamp END) AS start_ts,
         MAX(CASE WHEN activity_type = 'end'   THEN timestamp END) AS end_ts
  FROM Activity
  GROUP BY machine_id, process_id
)
SELECT machine_id, ROUND(AVG(TIMESTAMPDIFF(SECOND, start_ts, end_ts)), 3) AS processing_time
FROM pairs
GROUP BY machine_id;
```

- Recyclable and Low Fat Products (SQL100)
```sql
SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';
```

- Not Boring Movies (SQL101)
```sql
SELECT *
FROM Cinema
WHERE id % 2 = 1 AND description <> 'boring'
ORDER BY rating DESC;
```

- Rising Temperature (SQL102)
```sql
SELECT w1.id
FROM Weather w1
JOIN Weather w2 ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
               AND w1.city = w2.city
WHERE w1.temperature > w2.temperature;
```

- Confirmation Rate (SQL126)
```sql
SELECT s.user_id,
       ROUND(AVG(CASE WHEN c.action = 'confirmed' THEN 1.0 ELSE 0 END), 2) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON c.user_id = s.user_id
GROUP BY s.user_id;
```

- Invalid Tweets (SQL129)
```sql
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;
```

- Average Selling Price (SQL133)
```sql
SELECT p.product_id,
       ROUND(SUM(pr.price * u.units) / NULLIF(SUM(u.units), 0), 2) AS average_price
FROM Prices pr
JOIN UnitsSold u
  ON pr.product_id = u.product_id
 AND u.purchase_date BETWEEN pr.start_date AND pr.end_date
JOIN Products p ON p.product_id = u.product_id
GROUP BY p.product_id;
```

- Movie Rating (SQL134) – samples
```sql
-- 1) user with highest avg rating (ties by lexicographically smallest name)
SELECT name AS results
FROM (
  SELECT u.name, AVG(mr.rating) AS avg_rating,
         RANK() OVER (ORDER BY AVG(mr.rating) DESC, u.name ASC) r
  FROM MovieRating mr
  JOIN Users u ON u.user_id = mr.user_id
  GROUP BY u.user_id, u.name
) t WHERE r = 1
UNION ALL
-- 2) highest rated movie in Feb 2020 (ties by lexicographically smallest title)
SELECT title AS results
FROM (
  SELECT m.title,
         RANK() OVER (ORDER BY AVG(mr.rating) DESC, m.title ASC) r
  FROM MovieRating mr
  JOIN Movies m ON m.movie_id = mr.movie_id
  WHERE mr.created_at >= '2020-02-01' AND mr.created_at < '2020-03-01'
  GROUP BY m.movie_id, m.title
) t WHERE r = 1;
```

- Students and Examinations (SQL136)
```sql
SELECT s.student_id, s.student_name, sub.subject_name,
       COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
  ON e.student_id = s.student_id AND e.subject_name = sub.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
```

- Managers with at least 5 direct reports (SQL137)
```sql
SELECT m.name
FROM Employee e
JOIN Employee m ON m.id = e.managerId
GROUP BY m.id, m.name
HAVING COUNT(*) >= 5;
```

- Fix Names in a Table (SQL138)
```sql
SELECT user_id,
       CONCAT(UPPER(LEFT(name,1)), LOWER(SUBSTRING(name,2))) AS name
FROM Users
ORDER BY user_id;
```

- Employee Bonus (SQL139)
```sql
SELECT e.name, b.bonus
FROM Employee e
LEFT JOIN Bonus b ON b.empId = e.empId
WHERE b.bonus IS NULL OR b.bonus < 1000;
```

- Customer Who Bought All Products (SQL131)
```sql
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (
  SELECT COUNT(*) FROM Product
);
```

- Product Sales Analysis I (SQL130) – example
```sql
SELECT product_id, SUM(sales) AS total_sales
FROM Sales
GROUP BY product_id;
```

## 14) Practical checklist when solving any problem

- Draw the minimal schema you need (tables, keys, relevant columns)
- Decide join type(s): inner for matches, left for "including those without", anti-join for "without"
- Mark filters: WHERE vs ON, and time ranges
- Choose aggregation level: what you GROUP BY
- Compute measures with SUM/COUNT/AVG and CASE for conditional
- For per-group top-N, use ROW_NUMBER / RANK
- For sequences, use LAG/LEAD
- For DML tasks, ensure WHERE targets only intended rows; use transactions if needed

---
If you want, I can now generate tailored queries for a selected subset (or all) problems by parsing each HTML in `problems/` to infer table names and produce ready-to-run SQL files next to each problem.
