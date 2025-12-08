CREATE TABLE Orders (
    order_id VARCHAR(50),
    customer_name VARCHAR(100),
    order_date VARCHAR(20),
    status VARCHAR(20),
    total_amount INT
);

-- Tables: Orders
-- Technique: Altering table structure (dialect: MySQL)

ALTER TABLE Orders MODIFY COLUMN order_id INT NOT NULL AUTO_INCREMENT;
ALTER TABLE Orders ADD PRIMARY KEY (order_id);
ALTER TABLE Orders MODIFY COLUMN customer_name VARCHAR(100) NOT NULL;
ALTER TABLE Orders MODIFY COLUMN order_date DATE;
ALTER TABLE Orders MODIFY COLUMN status ENUM('PENDING', 'PAID', 'SHIPPED', 'CANCELLED') NOT NULL DEFAULT 'PENDING';
ALTER TABLE Orders MODIFY COLUMN total_amount DECIMAL(10,2);
ALTER TABLE Orders ADD COLUMN payment_method ENUM('CASH', 'CARD', 'TRANSFER') NOT NULL DEFAULT 'CASH';