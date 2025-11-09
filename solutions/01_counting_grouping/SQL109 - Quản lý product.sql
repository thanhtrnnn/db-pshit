-- Yêu cầu: Tạo bảng products quản lý thông tin sản phẩm cửa hàng bán lẻ.
-- Chú ý: product_id tự tăng, product_name NOT NULL, created_at mặc định CURRENT_TIMESTAMP.
-- MySQL syntax:
CREATE TABLE products (
	product_id INT AUTO_INCREMENT PRIMARY KEY,
	product_name VARCHAR(255) NOT NULL,
	category VARCHAR(100),
	price DECIMAL(10,2),
	stock_quantity INT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- PostgreSQL variant (sequence-based auto increment):
-- CREATE TABLE products (
--   product_id SERIAL PRIMARY KEY,
--   product_name VARCHAR(255) NOT NULL,
--   category VARCHAR(100),
--   price NUMERIC(10,2),
--   stock_quantity INT,
--   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );
