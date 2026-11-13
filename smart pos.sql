USE smart_pos_db;

DROP TABLE IF EXISTS sale_items;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Cashier') NOT NULL
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DOUBLE NOT NULL,
    stock_quantity INT NOT NULL,
    low_stock_threshold INT NOT NULL
);

CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    total_amount DOUBLE,
    sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE sale_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT,
    product_id INT,
    quantity INT,
    subtotal DOUBLE,
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO users (username, password, role) VALUES ('admin', '1234', 'Admin');
INSERT INTO products (name, category, price, stock_quantity, low_stock_threshold) VALUES 
('Wireless Mouse', 'Electronics', 1200.0, 15, 5),
('Mechanical Keyboard', 'Electronics', 3500.0, 3, 5),
('LED Monitor 24 inch', 'Electronics', 14500.0, 8, 5),
('Gaming Headset', 'Accessories', 2500.0, 4, 5),
('USB Type-C Hub', 'Accessories', 1100.0, 12, 5),
('External SSD 512GB', 'Storage', 6200.0, 2, 5),
('Bluetooth Speaker', 'Electronics', 3100.0, 10, 5),
('Webcam 1080p', 'Electronics', 2800.0, 6, 5),
('Desk Pad / Mouse Mat', 'Accessories', 600.0, 25, 5),
('Laptop Cooling Pad', 'Accessories', 1800.0, 4, 5);