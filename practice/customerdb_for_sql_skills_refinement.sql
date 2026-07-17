-- ============================================
-- ENHANCED CUSTOMER DATABASE - FINAL EXAM VERSION
-- ============================================

-- Drop tables if they exist
DROP TABLE IF EXISTS purchases;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS regions;

-- Create Regions Table
CREATE TABLE regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(50) NOT NULL,
    region_code VARCHAR(10) NOT NULL
);

-- Create Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(2) NOT NULL,
    region_id INT NOT NULL,
    membership_level VARCHAR(20) NOT NULL,
    join_date DATE NOT NULL,
    date_of_birth DATE NOT NULL,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

-- Create Suppliers Table
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(50) NOT NULL,
    contact_person VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL
);

-- Create Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(30) NOT NULL,
    supplier_id INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- Create Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    ship_date DATE,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create Order_Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    discount_percent DECIMAL(5, 2) DEFAULT 0,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create Purchases Table
CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    purchase_amount DECIMAL(10, 2) NOT NULL,
    purchase_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================
-- INSERT SAMPLE DATA
-- ============================================

-- Insert Regions
INSERT INTO regions (region_id, region_name, region_code) VALUES
(1, 'Northeast', 'NE'),
(2, 'Southeast', 'SE'),
(3, 'Midwest', 'MW'),
(4, 'Southwest', 'SW'),
(5, 'West', 'W');

-- Insert Original 20 Customers
INSERT INTO customers (customer_id, first_name, last_name, customer_name, email, city, state, region_id, membership_level, join_date, date_of_birth) VALUES
(1, 'Sarah', 'Johnson', 'Sarah Johnson', 'sarah.j@email.com', 'New York', 'NY', 1, 'Gold', '2023-01-15', '1985-03-22'),
(2, 'Mike', 'Chen', 'Mike Chen', 'mike.chen@gmail.com', 'Los Angeles', 'CA', 5, 'Silver', '2023-02-20', '1992-07-14'),
(3, 'Emily', 'Davis', 'Emily Davis', 'emily.d@email.com', 'Chicago', 'IL', 3, 'Gold', '2023-01-10', '1978-11-30'),
(4, 'James', 'Wilson', 'James Wilson', 'james.w@yahoo.com', 'Houston', 'TX', 4, 'Bronze', '2023-03-05', '1995-05-18'),
(5, 'Lisa', 'Anderson', 'Lisa Anderson', 'lisa.a@gmail.com', 'Phoenix', 'AZ', 4, 'Silver', '2023-02-14', '1988-09-08'),
(6, 'David', 'Martinez', 'David Martinez', 'david.m@email.com', 'New York', 'NY', 1, 'Gold', '2023-01-20', '1982-12-15'),
(7, 'Jennifer', 'Taylor', 'Jennifer Taylor', 'jennifer.t@yahoo.com', 'San Diego', 'CA', 5, 'Bronze', '2023-04-12', '1998-02-28'),
(8, 'Robert', 'Brown', 'Robert Brown', 'robert.b@gmail.com', 'Chicago', 'IL', 3, 'Silver', '2023-02-28', '1990-06-11'),
(9, 'Maria', 'Garcia', 'Maria Garcia', 'maria.g@email.com', 'Los Angeles', 'CA', 5, 'Gold', '2023-01-25', '1986-04-25'),
(10, 'Chris', 'Lee', 'Chris Lee', 'chris.l@yahoo.com', 'Houston', 'TX', 4, 'Bronze', '2023-05-08', '2000-01-07'),
(11, 'Amanda', 'White', 'Amanda White', 'amanda.w@gmail.com', 'Phoenix', 'AZ', 4, 'Silver', '2023-03-15', '1993-08-19'),
(12, 'Kevin', 'Clark', 'Kevin Clark', 'kevin.c@email.com', 'Boston', 'MA', 1, 'Gold', '2023-02-10', '1980-10-03'),
(13, 'Rachel', 'Adams', 'Rachel Adams', 'rachel.a@yahoo.com', 'Chicago', 'IL', 3, 'Bronze', '2023-04-20', '1996-12-21'),
(14, 'Daniel', 'Moore', 'Daniel Moore', 'daniel.m@gmail.com', 'San Francisco', 'CA', 5, 'Silver', '2023-03-22', '1987-07-30'),
(15, 'Jessica', 'Hall', 'Jessica Hall', 'jessica.h@email.com', 'San Diego', 'CA', 5, 'Gold', '2023-01-30', '1991-03-16'),
(16, 'Thomas', 'White', 'Thomas White', 'thomas.w@yahoo.com', 'Miami', 'FL', 2, 'Silver', '2023-02-18', '1984-05-09'),
(17, 'Patricia', 'King', 'Patricia King', 'patricia.k@gmail.com', 'Atlanta', 'GA', 2, 'Gold', '2023-01-12', '1979-09-14'),
(18, 'Michael', 'Scott', 'Michael Scott', 'michael.s@email.com', 'Dallas', 'TX', 4, 'Bronze', '2023-04-05', '1994-11-27'),
(19, 'Linda', 'Green', 'Linda Green', 'linda.g@yahoo.com', 'Seattle', 'WA', 5, 'Silver', '2023-03-10', '1989-01-23'),
(20, 'Steven', 'Baker', 'Steven Baker', 'steven.b@gmail.com', 'Philadelphia', 'PA', 1, 'Gold', '2023-02-25', '1983-08-05');

-- Insert 5 NEW Customers WITHOUT Purchases (for LEFT JOIN practice)
INSERT INTO customers (customer_id, first_name, last_name, customer_name, email, city, state, region_id, membership_level, join_date, date_of_birth) VALUES
(21, 'Alice', 'Newman', 'Alice Newman', 'alice.n@email.com', 'Portland', 'OR', 5, 'Bronze', '2024-05-15', '1997-04-12'),
(22, 'Brian', 'Foster', 'Brian Foster', 'brian.f@yahoo.com', 'Denver', 'CO', 3, 'Silver', '2024-05-20', '1990-09-28'),
(23, 'Carol', 'Peterson', 'Carol Peterson', 'carol.p@gmail.com', 'Austin', 'TX', 4, 'Bronze', '2024-05-22', '1999-11-05'),
(24, 'Derek', 'Hughes', 'Derek Hughes', 'derek.h@email.com', 'Charlotte', 'NC', 2, 'Gold', '2024-05-25', '1982-06-17'),
(25, 'Elena', 'Rivera', 'Elena Rivera', 'elena.r@yahoo.com', 'Minneapolis', 'MN', 3, 'Silver', '2024-05-28', '1995-02-14');

-- Insert 12 NEW Customers WITH Purchases (strategically placed for triplet self-joins)
INSERT INTO customers (customer_id, first_name, last_name, customer_name, email, city, state, region_id, membership_level, join_date, date_of_birth) VALUES
-- New York (needs Silver and Bronze)
(26, 'Nancy', 'Collins', 'Nancy Collins', 'nancy.c@email.com', 'New York', 'NY', 1, 'Silver', '2023-03-18', '1991-08-14'),
(27, 'Oliver', 'Murphy', 'Oliver Murphy', 'oliver.m@yahoo.com', 'New York', 'NY', 1, 'Bronze', '2023-04-22', '1996-01-09'),
-- Los Angeles (needs Bronze)
(28, 'Paula', 'Cooper', 'Paula Cooper', 'paula.c@gmail.com', 'Los Angeles', 'CA', 5, 'Bronze', '2023-03-08', '1993-11-22'),
-- Houston (needs Gold and Silver)
(29, 'Quinn', 'Reed', 'Quinn Reed', 'quinn.r@email.com', 'Houston', 'TX', 4, 'Gold', '2023-02-05', '1985-07-19'),
(30, 'Ryan', 'Bell', 'Ryan Bell', 'ryan.b@yahoo.com', 'Houston', 'TX', 4, 'Silver', '2023-03-28', '1992-03-25'),
-- Phoenix (needs Gold and Bronze)
(31, 'Sophia', 'Ward', 'Sophia Ward', 'sophia.w@gmail.com', 'Phoenix', 'AZ', 4, 'Gold', '2023-02-20', '1984-12-08'),
(32, 'Tyler', 'Ross', 'Tyler Ross', 'tyler.r@email.com', 'Phoenix', 'AZ', 4, 'Bronze', '2023-04-15', '1998-05-30'),
-- San Diego (needs Silver)
(33, 'Uma', 'Price', 'Uma Price', 'uma.p@yahoo.com', 'San Diego', 'CA', 5, 'Silver', '2023-03-12', '1990-09-17'),
-- Dallas (needs Gold and Silver)
(34, 'Victor', 'Morgan', 'Victor Morgan', 'victor.m@gmail.com', 'Dallas', 'TX', 4, 'Gold', '2023-01-28', '1981-10-14'),
(35, 'Wendy', 'James', 'Wendy James', 'wendy.j@email.com', 'Dallas', 'TX', 4, 'Silver', '2023-03-15', '1994-06-21'),
-- Seattle (needs Gold and Bronze)
(36, 'Xavier', 'Howard', 'Xavier Howard', 'xavier.h@yahoo.com', 'Seattle', 'WA', 5, 'Gold', '2023-02-12', '1983-04-03'),
(37, 'Yolanda', 'Russell', 'Yolanda Russell', 'yolanda.r@gmail.com', 'Seattle', 'WA', 5, 'Bronze', '2023-04-08', '1997-12-11');

-- Insert Original 5 Suppliers
INSERT INTO suppliers (supplier_id, supplier_name, contact_person, country) VALUES
(1, 'TechWorld Inc', 'John Smith', 'USA'),
(2, 'Global Electronics', 'Liu Wang', 'China'),
(3, 'Home Essentials Ltd', 'Emma Thompson', 'UK'),
(4, 'Sports Gear Co', 'Carlos Rodriguez', 'Spain'),
(5, 'Fashion Accessories', 'Marie Dubois', 'France');

-- Insert 2 NEW Suppliers WITHOUT Products (for LEFT JOIN practice)
INSERT INTO suppliers (supplier_id, supplier_name, contact_person, country) VALUES
(6, 'Future Tech Solutions', 'Sarah Kim', 'South Korea'),
(7, 'Eco Brands International', 'Marco Silva', 'Brazil');

-- Insert Original 15 Products
INSERT INTO products (product_id, product_name, category, supplier_id, unit_price, stock_quantity) VALUES
(101, 'Pro Laptop X1', 'Electronics', 1, 1299.99, 45),
(102, 'SmartPhone Pro', 'Electronics', 2, 899.99, 120),
(103, 'Wireless Headphones', 'Electronics', 2, 199.99, 85),
(104, 'Premium Coffee Maker', 'Appliances', 3, 129.99, 60),
(105, 'Multi Blender', 'Appliances', 3, 79.99, 75),
(106, 'Running Shoes Elite', 'Sports', 4, 119.99, 95),
(107, 'Yoga Mat Premium', 'Sports', 4, 39.99, 150),
(108, 'Travel Backpack', 'Accessories', 5, 69.99, 110),
(109, 'Stainless Water Bottle', 'Accessories', 5, 24.99, 200),
(110, 'LED Desk Lamp', 'Home', 3, 49.99, 80),
(111, 'Tablet Pro 10', 'Electronics', 1, 599.99, 55),
(112, 'Fitness Tracker', 'Electronics', 2, 149.99, 130),
(113, 'Camping Tent', 'Sports', 4, 249.99, 35),
(114, 'Designer Wallet', 'Accessories', 5, 89.99, 90),
(115, 'Smart Watch Ultra', 'Electronics', 1, 449.99, 65);

-- Insert 5 NEW Products (for more variety)
INSERT INTO products (product_id, product_name, category, supplier_id, unit_price, stock_quantity) VALUES
(116, 'Wireless Mouse Pro', 'Electronics', 2, 49.99, 150),
(117, 'Standing Desk Mat', 'Home', 3, 59.99, 70),
(118, 'Protein Shaker', 'Sports', 4, 19.99, 180),
(119, 'Leather Belt Premium', 'Accessories', 5, 45.99, 95),
(120, 'Air Purifier Compact', 'Appliances', 3, 179.99, 40);

-- Insert Original 40 Orders
INSERT INTO orders (order_id, customer_id, order_date, ship_date, status) VALUES
(1001, 1, '2024-01-15', '2024-01-17', 'Delivered'),
(1002, 2, '2024-01-16', '2024-01-19', 'Delivered'),
(1003, 3, '2024-01-18', '2024-01-20', 'Delivered'),
(1004, 4, '2024-01-20', '2024-01-23', 'Delivered'),
(1005, 5, '2024-01-22', '2024-01-25', 'Delivered'),
(1006, 1, '2024-02-01', '2024-02-04', 'Delivered'),
(1007, 6, '2024-02-03', '2024-02-06', 'Delivered'),
(1008, 7, '2024-02-05', '2024-02-08', 'Delivered'),
(1009, 8, '2024-02-08', '2024-02-11', 'Delivered'),
(1010, 9, '2024-02-10', '2024-02-13', 'Delivered'),
(1011, 3, '2024-02-15', '2024-02-18', 'Delivered'),
(1012, 10, '2024-02-18', '2024-02-21', 'Delivered'),
(1013, 11, '2024-02-20', '2024-02-23', 'Delivered'),
(1014, 12, '2024-02-25', '2024-02-28', 'Delivered'),
(1015, 2, '2024-03-01', '2024-03-04', 'Delivered'),
(1016, 13, '2024-03-05', '2024-03-08', 'Delivered'),
(1017, 14, '2024-03-08', '2024-03-11', 'Delivered'),
(1018, 15, '2024-03-10', '2024-03-13', 'Delivered'),
(1019, 16, '2024-03-15', '2024-03-18', 'Delivered'),
(1020, 17, '2024-03-18', '2024-03-21', 'Delivered'),
(1021, 9, '2024-03-22', '2024-03-25', 'Delivered'),
(1022, 18, '2024-03-25', '2024-03-28', 'Delivered'),
(1023, 19, '2024-04-01', '2024-04-04', 'Delivered'),
(1024, 20, '2024-04-03', '2024-04-06', 'Delivered'),
(1025, 3, '2024-04-05', '2024-04-08', 'Delivered'),
(1026, 1, '2024-04-10', '2024-04-13', 'Delivered'),
(1027, 5, '2024-04-12', '2024-04-15', 'Delivered'),
(1028, 6, '2024-04-15', '2024-04-18', 'Delivered'),
(1029, 8, '2024-04-18', '2024-04-21', 'Delivered'),
(1030, 12, '2024-04-22', '2024-04-25', 'Delivered'),
(1031, 15, '2024-05-01', '2024-05-04', 'Delivered'),
(1032, 17, '2024-05-05', '2024-05-08', 'Delivered'),
(1033, 2, '2024-05-08', '2024-05-11', 'Delivered'),
(1034, 9, '2024-05-12', '2024-05-15', 'Delivered'),
(1035, 14, '2024-05-15', '2024-05-18', 'Delivered'),
(1036, 7, '2024-05-18', NULL, 'Shipped'),
(1037, 10, '2024-05-20', NULL, 'Shipped'),
(1038, 11, '2024-05-22', NULL, 'Processing'),
(1039, 4, '2024-05-25', NULL, 'Processing'),
(1040, 13, '2024-05-27', NULL, 'Processing');

-- Insert 12 NEW Orders (for new customers 26-37)
INSERT INTO orders (order_id, customer_id, order_date, ship_date, status) VALUES
(1041, 26, '2024-03-20', '2024-03-23', 'Delivered'),
(1042, 27, '2024-04-02', '2024-04-05', 'Delivered'),
(1043, 28, '2024-03-15', '2024-03-18', 'Delivered'),
(1044, 29, '2024-02-28', '2024-03-02', 'Delivered'),
(1045, 30, '2024-04-08', '2024-04-11', 'Delivered'),
(1046, 31, '2024-03-05', '2024-03-08', 'Delivered'),
(1047, 32, '2024-04-18', '2024-04-21', 'Delivered'),
(1048, 33, '2024-03-22', '2024-03-25', 'Delivered'),
(1049, 34, '2024-02-15', '2024-02-18', 'Delivered'),
(1050, 35, '2024-03-28', '2024-03-31', 'Delivered'),
(1051, 36, '2024-03-10', '2024-03-13', 'Delivered'),
(1052, 37, '2024-04-22', '2024-04-25', 'Delivered');

-- Insert Original Order Items (keeping all original)
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
-- Original order items (1001-1040)
(1001, 101, 1, 1299.99, 5.00),
(1001, 103, 1, 199.99, 0.00),
(1002, 102, 1, 899.99, 10.00),
(1002, 109, 2, 24.99, 0.00),
(1003, 101, 1, 1299.99, 5.00),
(1003, 111, 1, 599.99, 5.00),
(1003, 103, 1, 199.99, 0.00),
(1004, 107, 2, 39.99, 0.00),
(1004, 109, 3, 24.99, 0.00),
(1005, 104, 1, 129.99, 0.00),
(1005, 105, 1, 79.99, 0.00),
(1005, 110, 1, 49.99, 0.00),
(1006, 108, 2, 69.99, 5.00),
(1006, 109, 4, 24.99, 0.00),
(1007, 115, 1, 449.99, 10.00),
(1007, 103, 1, 199.99, 10.00),
(1008, 106, 1, 119.99, 0.00),
(1008, 107, 1, 39.99, 0.00),
(1009, 104, 1, 129.99, 5.00),
(1009, 105, 1, 79.99, 5.00),
(1009, 110, 2, 49.99, 0.00),
(1010, 102, 1, 899.99, 10.00),
(1010, 112, 1, 149.99, 0.00),
(1010, 109, 2, 24.99, 0.00),
(1011, 111, 1, 599.99, 5.00),
(1011, 108, 1, 69.99, 0.00),
(1012, 107, 2, 39.99, 0.00),
(1012, 109, 3, 24.99, 0.00),
(1013, 104, 1, 129.99, 0.00),
(1013, 110, 1, 49.99, 0.00),
(1013, 103, 1, 199.99, 5.00),
(1014, 101, 1, 1299.99, 5.00),
(1014, 115, 1, 449.99, 5.00),
(1015, 106, 2, 119.99, 0.00),
(1015, 107, 1, 39.99, 0.00),
(1016, 108, 1, 69.99, 0.00),
(1016, 109, 5, 24.99, 0.00),
(1016, 114, 1, 89.99, 0.00),
(1017, 112, 1, 149.99, 5.00),
(1017, 106, 1, 119.99, 0.00),
(1018, 102, 1, 899.99, 10.00),
(1018, 103, 2, 199.99, 10.00),
(1019, 113, 1, 249.99, 0.00),
(1019, 107, 1, 39.99, 0.00),
(1020, 101, 1, 1299.99, 5.00),
(1020, 111, 1, 599.99, 5.00),
(1021, 115, 1, 449.99, 10.00),
(1021, 112, 1, 149.99, 10.00),
(1022, 107, 2, 39.99, 0.00),
(1022, 108, 1, 69.99, 0.00),
(1023, 104, 1, 129.99, 0.00),
(1023, 105, 1, 79.99, 0.00),
(1024, 101, 2, 1299.99, 10.00),
(1024, 103, 1, 199.99, 5.00),
(1025, 102, 1, 899.99, 10.00),
(1025, 112, 1, 149.99, 5.00),
(1026, 106, 2, 119.99, 5.00),
(1026, 109, 3, 24.99, 0.00),
(1027, 110, 2, 49.99, 0.00),
(1027, 105, 1, 79.99, 0.00),
(1028, 115, 1, 449.99, 10.00),
(1028, 103, 2, 199.99, 10.00),
(1029, 104, 1, 129.99, 5.00),
(1029, 110, 1, 49.99, 0.00),
(1030, 111, 1, 599.99, 5.00),
(1030, 108, 1, 69.99, 0.00),
(1031, 102, 1, 899.99, 10.00),
(1031, 114, 1, 89.99, 5.00),
(1032, 101, 1, 1299.99, 5.00),
(1032, 115, 1, 449.99, 5.00),
(1033, 106, 1, 119.99, 0.00),
(1033, 107, 2, 39.99, 0.00),
(1034, 112, 1, 149.99, 5.00),
(1034, 109, 4, 24.99, 0.00),
(1035, 103, 1, 199.99, 10.00),
(1035, 110, 2, 49.99, 0.00),
(1036, 113, 1, 249.99, 0.00),
(1036, 107, 1, 39.99, 0.00),
(1037, 105, 1, 79.99, 0.00),
(1037, 109, 2, 24.99, 0.00),
(1038, 104, 1, 129.99, 0.00),
(1038, 110, 1, 49.99, 0.00),
(1039, 108, 1, 69.99, 5.00),
(1039, 114, 1, 89.99, 0.00),
(1040, 107, 3, 39.99, 0.00),
(1040, 109, 5, 24.99, 0.00);

-- Insert NEW Order Items (for orders 1041-1052, including new products)
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(1041, 102, 1, 899.99, 5.00),
(1041, 116, 1, 49.99, 0.00),
(1042, 107, 1, 39.99, 0.00),
(1042, 118, 2, 19.99, 0.00),
(1043, 106, 1, 119.99, 0.00),
(1043, 109, 2, 24.99, 0.00),
(1044, 101, 1, 1299.99, 10.00),
(1044, 111, 1, 599.99, 5.00),
(1045, 112, 1, 149.99, 0.00),
(1045, 118, 1, 19.99, 0.00),
(1046, 115, 1, 449.99, 5.00),
(1046, 103, 1, 199.99, 0.00),
(1047, 107, 2, 39.99, 0.00),
(1047, 109, 3, 24.99, 0.00),
(1048, 108, 1, 69.99, 0.00),
(1048, 114, 1, 89.99, 5.00),
(1049, 101, 1, 1299.99, 5.00),
(1049, 116, 2, 49.99, 0.00),
(1050, 104, 1, 129.99, 0.00),
(1050, 120, 1, 179.99, 0.00),
(1051, 102, 1, 899.99, 10.00),
(1051, 112, 1, 149.99, 5.00),
(1052, 106, 1, 119.99, 0.00),
(1052, 107, 1, 39.99, 0.00),
(1052, 118, 2, 19.99, 0.00);

-- ============================================
-- Populate Purchases Table
-- ============================================

INSERT INTO purchases (customer_id, product_id, quantity, purchase_amount, purchase_date)
SELECT 
    o.customer_id,
    oi.product_id,
    oi.quantity,
    ROUND(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100), 2) AS purchase_amount,
    o.order_date
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
ORDER BY o.order_date, o.order_id;

-- ============================================
-- VERIFICATION QUERIES
-- ============================================

-- Verify customer count
SELECT 'Total Customers' AS Info, COUNT(*) AS Count FROM customers
UNION ALL
SELECT 'Customers WITH Purchases', COUNT(DISTINCT customer_id) FROM purchases
UNION ALL
SELECT 'Customers WITHOUT Purchases', COUNT(*) FROM customers WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM purchases);

-- Verify cities with complete triplets (Gold, Silver, Bronze)
SELECT 
    city,
    SUM(CASE WHEN membership_level = 'Gold' THEN 1 ELSE 0 END) AS Gold_Count,
    SUM(CASE WHEN membership_level = 'Silver' THEN 1 ELSE 0 END) AS Silver_Count,
    SUM(CASE WHEN membership_level = 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Count
FROM customers
GROUP BY city
HAVING SUM(CASE WHEN membership_level = 'Gold' THEN 1 ELSE 0 END) >= 1
   AND SUM(CASE WHEN membership_level = 'Silver' THEN 1 ELSE 0 END) >= 1
   AND SUM(CASE WHEN membership_level = 'Bronze' THEN 1 ELSE 0 END) >= 1
ORDER BY city;

-- Verify suppliers
SELECT 'Total Suppliers' AS Info, COUNT(*) AS Count FROM suppliers
UNION ALL
SELECT 'Suppliers WITH Products', COUNT(DISTINCT supplier_id) FROM products
UNION ALL
SELECT 'Suppliers WITHOUT Products', COUNT(*) FROM suppliers WHERE supplier_id NOT IN (SELECT DISTINCT supplier_id FROM products);

-- Verify total products and purchases
SELECT 'Total Products' AS Info, COUNT(*) AS Count FROM products
UNION ALL
SELECT 'Total Purchases', COUNT(*) FROM purchases
UNION ALL
SELECT 'Total Orders', COUNT(*) FROM orders;