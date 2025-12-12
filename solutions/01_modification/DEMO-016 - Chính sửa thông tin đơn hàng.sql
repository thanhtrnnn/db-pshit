-- Tables: Orders
-- Technique: Altering table structure (dialect: MySQL)

ALTER TABLE Orders 
    MODIFY order_id INT NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (order_id),
    MODIFY customer_name VARCHAR(100) NOT NULL,
    MODIFY order_date DATE,
    MODIFY status ENUM('PENDING', 'PAID', 'SHIPPED', 'CANCELLED') NOT NULL DEFAULT 'PENDING',
    MODIFY total_amount DECIMAL(10,2),
    ADD payment_method ENUM('CASH', 'CARD', 'TRANSFER') NOT NULL DEFAULT 'CASH';