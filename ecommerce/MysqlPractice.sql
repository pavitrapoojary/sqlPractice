-- Retrieve the names of all products in the "Electronics" category.
SELECT product_name FROM ecommerce.products WHERE category="Electronics";

-- Calculate the total revenue generated by a specific customer with the email address 'john@example.com'.	
SELECT SUM(products.price * order_items.quantity) AS total_revenue
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
INNER JOIN order_items ON orders.order_id = order_items.order_id
INNER JOIN products ON order_items.product_id = products.product_id
WHERE customers.email = 'john@example.com';

-- List the top 5 products with the highest average customer ratings, along with their average ratings.
SELECT p.product_name , AVG(pr.rating) AS average_rating
FROM products AS p
JOIN product_reviews AS pr
ON p.product_id = pr.product_id
GROUP BY p.product_id
ORDER BY average_rating DESC
LIMIT 5;

-- Find the number of products that are out of stock (stock_quantity = 0).
SELECT COUNT(*) AS out_of_stock_count
FROM ecommerce.products WHERE stock_quantity=0;

-- Retrieve the customer names who have placed more than 3 orders.
SELECT first_name, last_name FROM customers AS c
JOIN (SELECT customer_id , COUNT(*) AS order_count
FROM orders GROUP BY customer_id
HAVING order_count > 3) AS subquery
ON c.customer_id = subquery.customer_id;

-- List all products with their names, categories, and the corresponding customer names who reviewed them. Include products with no reviews.
SELECT p.product_name, p.category, CONCAT(c.first_name,' ',c.last_name) AS customer_name
FROM products p
LEFT JOIN product_reviews pr ON p.product_id=pr.product_id
LEFT JOIN customers c ON pr.customer_id=c.customer_id;

-- Find the total quantity of each product sold in orders placed after '2023-01-01'. Display the product name and total quantity sold.
SELECT p.product_name, SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_date > '2023-01-01'
GROUP BY p.product_name;

-- Retrieve the customers who have never placed an order.
SELECT CONCAT(first_name,' ',last_name) AS customer_name
FROM customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM orders);

-- Calculate the total revenue generated for each category of products. Display the category name and total revenue, ordered by revenue in descending order.
SELECT p.category, SUM(p.price*oi.quantity) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id=oi.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- List the customers who have placed orders with a total value exceeding $500. Include the customer's full name, email, and the total order value.
SELECT CONCAT(first_name,' ',last_name) AS customer_name, c.email, SUM(p.price*oi.quantity) AS total_order_value
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN order_items oi ON o.order_id=oi.order_id
JOIN products p ON oi.product_id=p.product_id
GROUP BY c.customer_id
HAVING total_order_value > 500;

-- Find the average stock quantity for each category of products. Display the category name and average stock quantity.
SELECT p.category , AVG(p.stock_quantity) AS avg_stock_quantity
FROM products p
GROUP BY p.category;

-- Retrieve the products with the lowest stock quantity (top 5) and their respective categories. Order them by stock quantity in ascending order.
SELECT p.product_name, p.category, p.stock_quantity
FROM products p
ORDER BY p.stock_quantity ASC
LIMIT 5;

-- List the customers who have placed orders in January 2023. Display the customer names and the number of orders they placed.
SELECT CONCAT(first_name,' ',last_name) AS customer_name, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
WHERE o.order_date BETWEEN '2023-01-01' AND '2023-01-31'
GROUP BY c.customer_id;

