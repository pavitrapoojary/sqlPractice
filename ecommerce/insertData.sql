-- Create the products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(255),
    price DECIMAL(10, 2),
    stock_quantity INT
);

-- Insert data into the products table
INSERT INTO products (product_id, product_name, category, price, stock_quantity)
VALUES
    (1, 'Laptop', 'Electronics', 800.00, 10),
    (2, 'Smartphone', 'Electronics', 500.00, 15),
    (3, 'T-shirt', 'Clothing', 20.00, 50),
    (4, 'Headphones', 'Electronics', 100.00, 20),
    (5, 'Jeans', 'Clothing', 40.00, 30);

-- Create the customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255)
);

-- Insert data into the customers table
INSERT INTO customers (customer_id, first_name, last_name, email)
VALUES
    (1, 'John', 'Doe', 'john@example.com'),
    (2, 'Alice', 'Smith', 'alice@example.com'),
    (3, 'Bob', 'Johnson', 'bob@example.com'),
    (4, 'Eva', 'Lee', 'eva@example.com'),
    (5, 'Michael', 'Brown', 'michael@example.com');

-- Create the orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert data into the orders table
INSERT INTO orders (order_id, customer_id, order_date)
VALUES
    (1, 1, '2023-01-05'),
    (2, 2, '2023-02-10'),
    (3, 3, '2023-03-15'),
    (4, 4, '2023-04-20'),
    (5, 5, '2023-05-25');

-- Create the order_items table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert data into the order_items table
INSERT INTO order_items (order_item_id, order_id, product_id, quantity)
VALUES
    (1, 1, 1, 2),
    (2, 2, 2, 3),
    (3, 3, 3, 5),
    (4, 4, 4, 2),
    (5, 5, 5, 4);

-- Create the product_reviews table
CREATE TABLE product_reviews (
    review_id INT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    rating INT,
    review_text TEXT,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert data into the product_reviews table
INSERT INTO product_reviews (review_id, product_id, customer_id, rating, review_text)
VALUES
    (1, 1, 1, 4, 'Great laptop for work and gaming!'),
    (2, 2, 2, 5, 'Love this smartphone. Amazing camera!'),
    (3, 3, 3, 3, 'Nice T-shirt, but the size is a bit small.'),
    (4, 4, 4, 4, 'Good headphones with clear sound.'),
    (5, 1, 5, 5, 'Excellent laptop, worth the price.');
