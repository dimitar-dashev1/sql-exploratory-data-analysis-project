/* Grouping customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than €5,000;
	- Regular: Customers with at least 12 months of history but spending €5,000 or less; 
	- New: Customers with a history of less than 12 months.
And finding the total number of customers by each group */
WITH customer_spending AS (
	SELECT
		c.customer_key,
		SUM (f.sales_amount) AS [total_spending],
		MIN (order_date) AS [first_order],
		MAX (order_date) AS [latest_order],
		DATEDIFF (month, MIN (order_date), MAX (order_date)) AS [lifespan_month]
	FROM fact_sales AS [f]
	LEFT JOIN dim_customers AS [c]
	ON f.customer_key = c.customer_key
	GROUP BY c.customer_key)
SELECT
	customer_segment,
	COUNT (customer_key) AS [total_customers]
FROM (
	SELECT
		customer_key,
	CASE WHEN lifespan_month >= 12 AND total_spending > 5000 THEN 'VIP'
		 WHEN lifespan_month >= 12 AND total_spending <= 5000 THEN 'Regular'
	ELSE 'New'
	END AS [customer_segment]
	FROM customer_spending)t
GROUP BY customer_segment
ORDER BY total_customers DESC