CREATE DATABASE IF NOT EXISTS pizza_restaurant;

USE pizza_restaurant;

-- Q1:  Create the Customers table
CREATE TABLE Customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  phone_number VARCHAR(20) NOT NULL
);
INSERT INTO Customers (name, phone_number)
VALUES ('Trevor Page', '226-555-4982'),
       ('John Doe', '555-555-9498');
       
-- Q2: Create the Pizzas table
CREATE TABLE Pizzas (
  pizza_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  price DECIMAL(6, 2) NOT NULL
);

-- Q3: Create the Orders table
CREATE TABLE Orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_datetime DATETIME NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE Order_Items (
  order_id INT NOT NULL,
  pizza_id INT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (order_id, pizza_id),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (pizza_id) REFERENCES Pizzas(pizza_id)
);
INSERT INTO Orders (customer_id, order_datetime)
VALUES (1, '2014-09-10 09:47:00'),
       (2, '2014-09-10 13:20:00'),
       (1, '2014-09-11 12:00:00');
INSERT INTO Order_Items (order_id, pizza_id, quantity)
VALUES (1, 1, 1),
       (1, 3, 1),
       (2, 2, 1),
       (2, 3, 2),
       (3, 3, 1),
       (3, 4, 1);
       
-- Q4
SELECT Customers.name, SUM(Pizzas.price * Order_Items.quantity) AS total_spent
FROM Customers
JOIN Orders ON Customers.customer_id = Orders.customer_id
JOIN Order_Items ON Orders.order_id = Order_Items.order_id
JOIN Pizzas ON Order_Items.pizza_id = Pizzas.pizza_id
GROUP BY Customers.customer_id
ORDER BY total_spent DESC;

-- Q5
SELECT c.name AS customer_name, DATE(o.order_datetime) AS order_date, SUM(p.price * oi.quantity) AS total_spent
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id
INNER JOIN Order_Items oi ON o.order_id = oi.order_id
INNER JOIN Pizzas p ON oi.pizza_id = p.pizza_id
GROUP BY c.customer_id, DATE(o.order_datetime)
ORDER BY c.customer_id, DATE(o.order_datetime);


