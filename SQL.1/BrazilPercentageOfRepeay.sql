WITH CustomerOrderCounts AS
(
    SELECT 
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS orders
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    COUNT(CASE WHEN orders >= 2 THEN 1 END) AS RepeatCustomers,
    COUNT(*) AS TotalCustomers,
    COUNT(CASE WHEN orders >= 2 THEN 1 END) * 100.0 / COUNT(*) AS RepeatCustomerRate
FROM CustomerOrderCounts;