					MySQL Task

1)To create database
  Create database ecommerce;
2)To create customers table
  CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    address VARCHAR(255)
  );
3)To create orders table
  CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
  );

4)To create products table
    CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description VARCHAR(255)
);

5) To insert in customers table
  INSERT INTO `customers` (`id`, `name`, `email`, `address`) VALUES (NULL, 'manoj', 'manoj@gmail.com', 'a street');

6)To insert in products table
  INSERT INTO `products` (`id`, `name`, `price`, `description`) VALUES (NULL, 'A', '50', Rice');


Queries
Retrieve all customers who have placed an order in the last 30 days.

SELECT DISTINCT customer.name, customer.email FROM customers customer JOIN orders order ON customer.id = order.customer_id WHERE order.order_date >= CURDATE() - INTERVAL 30 DAY;

Note 
	1)DISTINCT keyword make sure that customer name or id did not repeat, it returns the single value even it has more than one value
	2)Join keyword will join two tables customers and orders
	3)CURDATE() will return the present date

Update the price of Product C to 45.00.
UPDATE products SET price = 45.00 WHERE name = 'C';

Note 
	1)Update keyword is used to update a record in a table 
	2)set keyword is used to which fields should be updated



Get the total amount of all orders placed by each customer.
SELECT customer.id, customer.name, SUM(order.total_amount) AS total_spent
FROM customers customer
JOIN orders order ON customer.id = order.customer_id
GROUP BY customer.id;

Note: 
    SUM is a aggregate function to add a data in column
   
Add a new column discount to the products table.
ALTER TABLE products ADD COLUMN discount DECIMAL(5, 2);
Note:
1)	Alter table is used to add, delete, update a column

Retrieve the top 3 products with the highest price.
SELECT id, name, price, description FROM products ORDER BY price DESC LIMIT 3;
Note :
  1)order by key word is used to sort the result set ascending or descending with the given column.
  2) LIMIT key word used to limit the number of records to retrieve

Get the names of customers who have ordered Product A
SELECT customer.customer
FROM customers customer
JOIN orders order ON customer.id = order.customer_id
JOIN products product ON orders.product_id = product.id
WHERE product.name = 'Product A';



Join the orders and customers tables to retrieve the customer's name and order date for each order.
SELECT c.name, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.id;

Retrieve the orders with a total amount greater than 150.00.
SELECT * 
FROM orders
WHERE total_amount > 150.00;

Normalize the database by creating a separate table for order items and updating the orders table to reference the order_items table.

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT DEFAULT 1,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

Note : 
    To normalize the database we have separate the order table with order_items table where the orders is foreign key.



Retrieve the average total of all orders.
Select AVG(order_item.total_amount) from orders order JOIN
Order_items order_item ON order_item.order_id = order.id
GROUP BY order.id

Note : 
 AVG is a aggregate function to get the average of the specified column


