# SQL Recipes & Taxonomy Guide (Hướng dẫn Phân loại & Công thức SQL)

Hướng dẫn toàn diện về 10 danh mục phân loại SQL trong dự án này, kèm theo ví dụ và mô tả chi tiết.

---

## 1. Modification (Chỉnh sửa / DML & DDL)

**Mô tả (Vietnamese):**
Các phép toán thay đổi dữ liệu hoặc cấu trúc bảng. Bao gồm INSERT, UPDATE, DELETE, MERGE, CREATE TABLE, ALTER TABLE, DROP TABLE, và các câu lệnh DDL/DML khác.

**Thư mục:** `solutions/01_modification/`

**Ví dụ:**
```sql
-- INSERT new records
INSERT INTO users (id, name, email) 
VALUES (1, 'John Doe', 'john@example.com');

-- UPDATE existing records
UPDATE products SET price = price * 1.1 WHERE category = 'electronics';

-- DELETE records
DELETE FROM logs WHERE created_at < DATEADD(MONTH, -1, GETDATE());

-- MERGE (upsert pattern)
MERGE INTO target AS t
USING source AS s
ON t.id = s.id
WHEN MATCHED THEN UPDATE SET t.value = s.value
WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
```

**Từ khóa nhận dạng:** INSERT, UPDATE, DELETE, MERGE, CREATE, ALTER, DROP, TRUNCATE

---

## 2. Aggregation (Tập hợp / Kỳ tích)

**Mô tả (Vietnamese):**
Các truy vấn sử dụng hàm tập hợp (aggregate functions) để tóm tắt dữ liệu, thường kết hợp với GROUP BY. Áp dụng các phép toán như COUNT, SUM, AVG, MIN, MAX trên nhóm dữ liệu.

**Thư mục:** `solutions/02_aggregation/`

**Ví dụ:**
```sql
-- Simple aggregation
SELECT COUNT(*) AS total_orders, SUM(amount) AS total_sales
FROM orders;

-- GROUP BY aggregation
SELECT 
    department,
    COUNT(*) AS employee_count,
    AVG(salary) AS avg_salary,
    MAX(salary) AS max_salary
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;

-- COUNT DISTINCT
SELECT category, COUNT(DISTINCT product_id) AS unique_products
FROM sales
GROUP BY category;
```

**Từ khóa nhận dạng:** COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING

---

## 3. Grouping + Having (Nhóm & Điều kiện HAVING)

**Mô tả (Vietnamese):**
Các truy vấn nhấn mạnh `GROUP BY` kết hợp `HAVING` để lọc sau khi tổng hợp, hoặc yêu cầu xác định Top-N trong từng nhóm (ví dụ: NV có doanh số cao nhất mỗi phòng ban). Nhiều bài toán dùng `ROW_NUMBER`/`RANK` để hỗ trợ chọn các bản ghi tốt nhất trong nhóm nhưng kết quả cuối cùng vẫn dựa trên tiêu chí nhóm.

**Thư mục:** `solutions/03_grouping_having/`

**Ví dụ:**
```sql
-- HAVING với điều kiện đếm
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) >= 5;

-- HAVING với SUM
SELECT customer_id, SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(amount) > 1000;

-- Top 3 nhân viên doanh số cao nhất mỗi phòng (dùng window để lọc)
WITH ranked AS (
    SELECT 
        department_id,
        employee_id,
        SUM(amount) AS total_sales,
        ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY SUM(amount) DESC) AS rn
    FROM sales
    GROUP BY department_id, employee_id
)
SELECT *
FROM ranked
WHERE rn <= 3;
```

**Từ khóa nhận dạng:** HAVING, GROUP BY ... HAVING, Top-N per group, ROW_NUMBER, RANK, DENSE_RANK

---

## 4. Pivoting (Xoay bảng / Chuyển đổi cột)

**Mô tả (Vietnamese):**
Các truy vấn biến các hàng thành cột (chuyển đổi dữ liệu từ dạng dài sang dạng rộng). Sử dụng PIVOT, hoặc các biểu thức CASE kết hợp với hàm tập hợp để tạo ra bảng dạng ma trận.

**Thư mục:** `solutions/04_pivoting/`

**Ví dụ:**
```sql
-- PIVOT syntax (SQL Server)
SELECT *
FROM (
    SELECT month, sales_amount
    FROM monthly_sales
)
PIVOT (
    SUM(sales_amount)
    FOR month IN ([January], [February], [March])
) AS pvt;

-- CASE-based pivoting (portable across databases)
SELECT 
    product_id,
    SUM(CASE WHEN quarter = 'Q1' THEN revenue ELSE 0 END) AS Q1_revenue,
    SUM(CASE WHEN quarter = 'Q2' THEN revenue ELSE 0 END) AS Q2_revenue,
    SUM(CASE WHEN quarter = 'Q3' THEN revenue ELSE 0 END) AS Q3_revenue,
    SUM(CASE WHEN quarter = 'Q4' THEN revenue ELSE 0 END) AS Q4_revenue
FROM sales
GROUP BY product_id;

-- Conditional aggregation
SELECT 
    store_id,
    COUNT(CASE WHEN status = 'completed' THEN 1 END) AS completed_orders,
    COUNT(CASE WHEN status = 'pending' THEN 1 END) AS pending_orders
FROM orders
GROUP BY store_id;
```

**Từ khóa nhận dạng:** PIVOT, FOR...IN, CASE...WHEN...THEN (trong SELECT với GROUP BY)

---

## 5. Set Operations (Phép Toán Tập Hợp)

**Mô tả (Vietnamese):**
Các truy vấn kết hợp kết quả từ nhiều SELECT bằng cách sử dụng UNION (tất cả hoặc distinct), INTERSECT (giao tập), hoặc EXCEPT (hiệu tập).

**Thư mục:** `solutions/05_set_operations/`

**Ví dụ:**
```sql
-- UNION (loại bỏ duplicates)
SELECT user_id, 'premium' AS type FROM premium_users
UNION
SELECT user_id, 'free' AS type FROM free_users;

-- UNION ALL (giữ duplicates)
SELECT order_id FROM orders_2022
UNION ALL
SELECT order_id FROM orders_2023;

-- INTERSECT (các user vừa là premium vừa là active)
SELECT user_id FROM premium_users
INTERSECT
SELECT user_id FROM active_users;

-- EXCEPT (các user premium nhưng không active)
SELECT user_id FROM premium_users
EXCEPT
SELECT user_id FROM active_users;
```

**Từ khóa nhận dạng:** UNION, UNION ALL, INTERSECT, EXCEPT

---

## 6. Relational Division (Phép Chia Quan Hệ)

**Mô tả (Vietnamese):**
Các truy vấn tìm kiếm hàng mà có **tất cả** những đặc điểm hoặc kết nối cụ thể. Thường sử dụng NOT EXISTS với ALL, COUNT(DISTINCT), hoặc GROUP BY...HAVING COUNT(*) để xác định bộ hoàn chỉnh.

**Thư mục:** `solutions/06_relational_division/`

**Ví dụ:**
```sql
-- Tìm khách hàng đã mua TẤT CẢ các sản phẩm
SELECT c.customer_id, c.customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1 FROM products p
    WHERE NOT EXISTS (
        SELECT 1 FROM orders o
        WHERE o.customer_id = c.customer_id
        AND o.product_id = p.product_id
    )
);

-- Sử dụng GROUP BY...HAVING
SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(DISTINCT product_id) = (SELECT COUNT(*) FROM products);

-- Tìm nhân viên tham gia TẤT CẢ các dự án
SELECT e.employee_id
FROM employees e
WHERE (SELECT COUNT(DISTINCT project_id) FROM assignments WHERE employee_id = e.employee_id)
    = (SELECT COUNT(*) FROM projects);
```

**Từ khóa nhận dạng:** NOT EXISTS, ALL, EVERY, GROUP BY...HAVING COUNT(DISTINCT...)

---

## 7. Complex Join (Kết Nối Phức Tạp)

**Mô tả (Vietnamese):**
Các truy vấn sử dụng các kết nối nâng cao như range join (kết nối dựa trên khoảng), kết nối với điều kiện phức tạp hơn so với bằng nhau (>=, <=, BETWEEN), hoặc nhiều kết nối lồng nhau với điều kiện non-equijoin.

**Thư mục:** `solutions/07_complex_join/`

**Ví dụ:**
```sql
-- Range join (kết nối trong khoảng)
SELECT o.order_id, o.amount, ps.price_from, ps.price_to
FROM orders o
JOIN price_slabs ps
    ON o.amount >= ps.price_from
    AND o.amount <= ps.price_to;

-- Self-join to find overlapping ranges
SELECT a.id, b.id
FROM appointments a
JOIN appointments b
    ON a.room_id = b.room_id
    AND a.start_time < b.end_time
    AND b.start_time < a.end_time
WHERE a.id < b.id;

-- Multiple complex conditions
SELECT e.employee_id, d.department_id, p.project_id
FROM employees e
JOIN departments d ON e.dept_id = d.id
JOIN projects p ON p.budget >= e.salary * 12 AND p.dept_id = d.id
WHERE e.hire_date <= p.start_date;
```

**Từ khóa nhận dạng:** JOIN...ON (với >=, <=, <, >, BETWEEN), SELF JOIN, multiple joins với điều kiện non-equi

---

## 8. Filtering (Lọc / Xử Lý Ngày & Chuỗi)

**Mô tả (Vietnamese):**
Các truy vấn sử dụng các hàm xử lý ngày tháng (DATE, DATEADD, DATEDIFF, EXTRACT, MONTH, YEAR) hoặc hàm xử lý chuỗi (UPPER, LOWER, TRIM, SUBSTRING, REPLACE, LIKE, REGEX) để lọc và biến đổi dữ liệu.

**Thư mục:** `solutions/08_filtering/`

**Ví dụ:**
```sql
-- Date filtering
SELECT *
FROM orders
WHERE order_date >= DATEADD(MONTH, -3, GETDATE())
AND order_date < GETDATE();

-- DATEDIFF
SELECT 
    employee_id,
    hire_date,
    DATEDIFF(YEAR, hire_date, GETDATE()) AS years_employed
FROM employees;

-- String functions
SELECT *
FROM customers
WHERE UPPER(city) = 'HANOI'
AND LOWER(status) = 'active'
AND LEN(phone_number) = 10;

-- SUBSTRING and LIKE
SELECT *
FROM users
WHERE SUBSTRING(email, 1, CHARINDEX('@', email) - 1) LIKE '%john%'
OR email LIKE '%.edu';

-- REPLACE
SELECT 
    name,
    REPLACE(phone_number, '-', '') AS normalized_phone
FROM contacts;

-- Regular expression (database-specific)
SELECT * FROM logs WHERE message REGEXP '^ERROR:.*timeout$';
```

**Từ khóa nhận dạng:** DATEADD, DATEDIFF, GETDATE, EXTRACT, MONTH, YEAR, DAY, UPPER, LOWER, TRIM, SUBSTRING, REPLACE, LIKE, REGEXP, LEN, CHARINDEX

---

## 9. Retrieval (Lấy Dữ Liệu / Cơ Bản)

**Mô tả (Vietnamese):**
Các truy vấn SELECT cơ bản để lấy dữ liệu từ một hoặc nhiều bảng với các kết nối đơn giản (INNER JOIN, LEFT JOIN, RIGHT JOIN) và các điều kiện lọc cơ bản.

**Thư mục:** `solutions/09_retrieval/`

**Ví dụ:**
```sql
-- Simple SELECT
SELECT product_id, product_name, price
FROM products
WHERE category = 'electronics';

-- INNER JOIN
SELECT o.order_id, c.customer_name, o.amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- LEFT JOIN
SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS num_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE c.country = 'Vietnam'
GROUP BY c.customer_id, c.customer_name;

-- ORDER BY
SELECT *
FROM employees
WHERE department = 'Sales'
ORDER BY salary DESC, hire_date ASC;

-- DISTINCT
SELECT DISTINCT category FROM products;
```

**Từ khóa nhận dạng:** SELECT...FROM, INNER JOIN, LEFT JOIN, RIGHT JOIN, WHERE, ORDER BY, DISTINCT, GROUP BY (cơ bản)

---

## 10. Complex (Phức Tạp / Kỹ Thuật Kết Hợp)

**Mô tả (Vietnamese):**
Các truy vấn sử dụng kết hợp **nhiều kỹ thuật** từ các danh mục khác hoặc sử dụng cách tiếp cận nâng cao như WITH (CTE), subqueries lồng nhau, hoặc sự kết hợp của window functions + aggregation + joins phức tạp.

**Thư mục:** `solutions/10_complex/`

**Ví dụ:**
```sql
-- CTE with aggregation and window functions
WITH monthly_sales AS (
    SELECT 
        YEAR(order_date) AS year,
        MONTH(order_date) AS month,
        SUM(amount) AS total_sales
    FROM orders
    GROUP BY YEAR(order_date), MONTH(order_date)
),
ranked_sales AS (
    SELECT 
        year,
        month,
        total_sales,
        ROW_NUMBER() OVER (PARTITION BY year ORDER BY total_sales DESC) AS rank_in_year
    FROM monthly_sales
)
SELECT * FROM ranked_sales WHERE rank_in_year <= 3;

-- Multiple JOINs with filtering and aggregation
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS emp_count,
    AVG(e.salary) AS avg_salary,
    MAX(p.project_count) AS max_projects_per_emp
FROM departments d
LEFT JOIN employees e ON d.id = e.dept_id
LEFT JOIN (
    SELECT employee_id, COUNT(*) AS project_count
    FROM project_assignments
    GROUP BY employee_id
) p ON e.employee_id = p.employee_id
WHERE d.active = 1
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 0;

-- Nested subqueries with CASE and UNION
SELECT 
    'high_value' AS customer_segment,
    customer_id
FROM customers
WHERE total_purchases > (SELECT AVG(total_purchases) * 2 FROM customers)
UNION
SELECT 
    'low_frequency',
    customer_id
FROM customers
WHERE last_order_date < DATEADD(MONTH, -6, GETDATE());
```

**Từ khóa nhận dạng:** WITH...AS (CTE), multiple subqueries, kết hợp WINDOW + AGGREGATION + JOIN, UNION, CASE...WHEN (phức tạp)

---

## Quick Reference Table

| Danh mục | Folder | Từ khóa chính | Đặc điểm |
|----------|--------|--------------|---------|
| **Modification** | `01_modification/` | INSERT, UPDATE, DELETE, MERGE | Thay đổi dữ liệu |
| **Aggregation** | `02_aggregation/` | COUNT, SUM, AVG, GROUP BY, HAVING | Tóm tắt / Kỳ tích |
| **Grouping + Having** | `03_grouping_having/` | GROUP BY ... HAVING, Top-N per group, ROW_NUMBER | Lọc sau tổng hợp |
| **Pivoting** | `04_pivoting/` | PIVOT, CASE...THEN...SUM | Xoay cột |
| **Set Operations** | `05_set_operations/` | UNION, INTERSECT, EXCEPT | Kết hợp tập hợp |
| **Relational Division** | `06_relational_division/` | NOT EXISTS, ALL, HAVING COUNT(DISTINCT) | Tất cả các đặc điểm |
| **Complex Join** | `07_complex_join/` | JOIN...ON (>=, <=, BETWEEN), SELF JOIN | Kết nối nâng cao |
| **Filtering** | `08_filtering/` | DATE, SUBSTRING, UPPER, LIKE, REGEXP | Xử lý ngày/chuỗi |
| **Retrieval** | `09_retrieval/` | SELECT, INNER/LEFT JOIN, WHERE, ORDER BY | Cơ bản / Lấy dữ liệu |
| **Complex** | `10_complex/` | WITH, CTE, multiple techniques | Kỹ thuật kết hợp |

---

## Quy Trình Phân Loại (Classification Decision Tree)

Khi nhận dữ liệu từ một bài toán, tuân theo quy trình này:

1. **Có INSERT/UPDATE/DELETE/MERGE/DDL?** → **Modification**
2. **Không.** Có GROUP BY + HAVING hoặc yêu cầu Top-N per group (ROW_NUMBER/RANK)?** → **Grouping + Having**
3. **Không.** Có UNION/INTERSECT/EXCEPT?** → **Set Operations**
4. **Không.** Có PIVOT hoặc CASE...SUM...GROUP BY (dạng ma trận)?** → **Pivoting**
5. **Không.** Có NOT EXISTS + ALL hoặc HAVING COUNT(DISTINCT) (tìm tất cả)?** → **Relational Division**
6. **Không.** Có range join (>=, <=, BETWEEN) hoặc self-join phức tạp?** → **Complex Join**
7. **Không.** Có hàm ngày (DATEADD, DATEDIFF) hoặc chuỗi (UPPER, SUBSTRING, REGEX)?** → **Filtering**
8. **Không.** Có GROUP BY + COUNT/SUM/AVG mà không có OVER()?** → **Aggregation**
9. **Không.** Có WITH (CTE) hoặc kết hợp nhiều kỹ thuật?** → **Complex**
10. **Mặc định:** Basic SELECT + JOIN → **Retrieval**

---

## Ghi chú

- Các ví dụ sử dụng SQL Server dialect; có thể cần điều chỉnh nhẹ cho MySQL, PostgreSQL, v.v.
- Một truy vấn có thể kết hợp nhiều kỹ thuật; hãy chọn danh mục dựa trên **kỹ thuật chủ yếu**.
- Tham khảo `evaluation.md` để biết chi tiết hơn về các quy tắc phân loại.
