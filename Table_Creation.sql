------------------------------	CREATE TABLE ------------------------------	
---------- 1. Create Table "Customers"

CREATE TABLE customers
(
	customer_id INT PRIMARY KEY,
	customer_name VARCHAR(100),
	signup_date DATE,
	country VARCHAR(50)
);

---------- 2. Create Table "Orders"

CREATE TABLE orders
(
	order_id INT PRIMARY KEY,
	customer_id INT REFERENCES customers(customer_id),
	order_date DATE,
	order_status VARCHAR(20),
	order_amount DECIMAL(12,2)
);

---------- 3. Create Table "Order Items"

CREATE TABLE order_items
(
	item_id INT PRIMARY KEY,
	order_id INT REFERENCES orders(order_id),
	product_category VARCHAR(50),
	product_name VARCHAR(100),
	quantity INT,
	unit_price DECIMAL(12,2)
);


----------------- 1. Insert records into customers table ----------------- 

INSERT INTO customers VALUES
(1, 'Alice Smith', '2024-01-10', 'India'),
(2, 'Bob Jones', '2024-01-15', 'USA'),
(3, 'Charlie Brown', '2024-02-01', 'India'),
(4, 'Diana Prince', '2024-02-15', 'UK'),
(5, 'Evan Wright', '2024-03-01', 'USA');

----------------- 2. Insert records into order table ----------------- 

INSERT INTO orders VALUES
(101, 1, '2024-01-12', 'completed', 150.00),
(102, 2, '2024-01-20', 'completed', 300.00),
(103, 1, '2024-02-14', 'completed', 220.00),
(104, 3, '2024-02-18', 'completed', 450.00),
(105, 2, '2024-02-25', 'cancelled', 180.00),
(106, 4, '2024-03-05', 'completed', 500.00),
(107, 1, '2024-03-10', 'completed', 130.00),
(108, 5, '2024-03-15', 'completed', 75.00),
(109, 3, '2024-03-22', 'completed', 310.00);
UPDATE orders
SET order_status ='cancelled'
WHERE order_id = 105;

UPDATE orders
SET order_status = 
CASE 
	WHEN order_id = 105 THEN 'cancelled'
	WHEN order_id = 108 THEN 'returned'
END
	WHERE order_id IN(105,108) ;

----------------- 3. Insert records into order items table ----------------- 

INSERT INTO order_items VALUES
(1, 101, 'Electronics', 'Wireless Mouse', 2, 75.00),
(2, 102, 'Furniture', 'Ergonomic Chair', 1, 300.00),
(3, 103, 'Electronics', 'Mechanical Keyboard', 2, 110.00),
(4, 104, 'Appliances', 'Air Fryer', 1, 450.00),
(5, 106, 'Electronics', 'Ultrawide Monitor', 1, 500.00),
(6, 107, 'Books', 'Data Architecture Handbook', 2, 65.00),
(7, 108, 'Electronics', 'USB-C Dock', 1, 75.00),
(8, 109, 'Appliances', 'Espresso Maker', 1, 310.00);

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;


