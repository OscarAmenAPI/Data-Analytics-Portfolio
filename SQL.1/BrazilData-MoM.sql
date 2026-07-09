-- Revenue MoM (Month over Month)
WITH TotalRevenue AS (
	SELECT
	FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS OrderMonth,
	SUM(op.payment_value) AS revenue
FROM order_payments op
JOIN orders o
	ON op.order_id = o.order_id
GROUP BY 
	FORMAT(o.order_purchase_timestamp, 'yyyy-MM')
)

SELECT 
	OrderMonth,
	revenue,
	
	ROUND (

	(revenue - LAG(revenue) OVER (ORDER BY OrderMonth))
	* 100 /
	LAG(revenue) OVER (ORDER BY OrderMonth),
	2
	)AS PercentageChange	

FROM TotalRevenue
ORDER BY OrderMonth