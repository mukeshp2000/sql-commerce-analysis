-- Analysis Queries

-- Total Revenue
SELECT SUM(p.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id;

-- Orders per customer
SELECT c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC;

--customers without orders
       SELECT c.customer_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

--average order value
SELECT AVG(order_total) AS average_order_value
FROM (
SELECT order_id,
SUM(quantity*price) AS order_total
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
GROUP BY order_id
)t;

--monthly revenue
SELECT month(order_date) AS month,
SUM(quantity * price)AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
JOIN products p
ON oi.product_id=p.product_id
GROUP BY month (order_date)
ORDER BY month;
