-- Total Revenue
SELECT
	SUM(payment_value) AS revenue
FROM order_payments

-- Total Customers
SELECT
	COUNT(DISTINCT customer_unique_id) AS TotalCustomers
FROM customers

-- Total Orders
SELECT
	COUNT(DISTINCT order_id)
FROM orders


-- Revenue by Month
SELECT
	MONTH(o.order_purchase_timestamp) AS OrderMonth,
	YEAR(o.order_purchase_timestamp) AS OrderYear,
	SUM(op.payment_value) AS revenue
FROM order_payments op
JOIN orders o
	ON op.order_id = o.order_id
GROUP BY 
	YEAR(o.order_purchase_timestamp),
	MONTH(o.order_purchase_timestamp)
ORDER BY 
	OrderYear,
	OrderMonth
	

-- Revenue by Product Category
SELECT TOP 5
	p.product_category_name,
	SUM(op.payment_value) AS Revenue
FROM order_items oi
JOIN products p
	ON oi.product_id = p.product_id
JOIN order_payments op
	ON oi.order_id = op.order_id
GROUP BY p.product_category_name
ORDER BY Revenue DESC

-- Top Customers by Revenue
SELECT 
	c.customer_unique_id,
	SUM(op.payment_value) AS Revenue
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id
JOIN order_payments op
	ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
ORDER BY Revenue DESC

-- Average Order Value
SELECT
	SUM(payment_value) / COUNT(DISTINCT Order_ID) AS AvgValuePerOrder
FROM clean_payment

-- Average Review Score
SELECT
	ROUND
	(
	SUM(review_score) * 1.0 / COUNT(DISTINCT Order_ID),
	1
	) AS AvgReviewScore
FROM clean_review

-- Average Delivery Time
SELECT
   AVG(
   ROUND(
        DATEDIFF(
            day,
            order_purchase_timestamp,
            order_delivered_customer_date
        ),
		2
    )
	
)AS AvgDeliveryDays
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;