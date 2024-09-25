-- 1.Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;

-- 2.Calculate the total revenue generated from pizza sales.

SELECT 
    p.pizza_id,
    ROUND(SUM(p.price * o.quantity)) AS total_revenue
FROM
    pizzas AS p
        INNER JOIN
    order_details AS o ON p.pizza_id = o.pizza_id
GROUP BY p.pizza_id;

-- 3.Identify the highest-priced pizza.

SELECT 
    *
FROM
    pizzas
ORDER BY price DESC
LIMIT 1;

-- 4.Identify the most common pizza size ordered.

SELECT 
    COUNT(order_details_id), p.size
FROM
    order_details AS o
        JOIN
    pizzas AS p ON o.pizza_id = p.pizza_id
GROUP BY p.size;

-- 5.List the top 5 most ordered pizza types along with their quantities.

SELECT 
    name, SUM(quantity)
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details AS o ON o.pizza_id = p.pizza_id
GROUP BY name
ORDER BY SUM(quantity) DESC
LIMIT 5;

-- 6.Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    category, SUM(quantity) AS quantity
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details AS o ON p.pizza_id = o.pizza_id
GROUP BY category;

--  7.Determine the distribution of orders by hour of the day.

SELECT 
    EXTRACT(HOUR FROM time) AS order_time,
    COUNT(order_id) AS order_count
FROM
    orders
GROUP BY EXTRACT(HOUR FROM time);

-- 8.Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

-- 9.Group the orders by date and calculate the average number of pizzas ordered per day.

select round(avg(quantity),0) as avg_pizzas_ordered_per_day from 
(SELECT 
    o.date, SUM(od.quantity) as quantity
FROM
    orders AS o
        JOIN
    order_details AS od ON o.order_id = od.order_id
GROUP BY o.date) as order_quantity; 

-- 10.Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    name, ROUND(SUM(price * quantity), 0) AS revenue
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details AS o ON o.pizza_id = p.pizza_id
GROUP BY name
ORDER BY SUM(price * quantity) DESC
LIMIT 3;


