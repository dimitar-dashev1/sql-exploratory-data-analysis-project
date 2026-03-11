/* Calculating the:
1. Total sales per year
2. Running total of sales over time
3. Moving average of the price */
SELECT
	order_date,
	total_sales,
	SUM (total_sales) OVER (ORDER BY order_date) AS [sales_running_total],
	AVG (avg_price) OVER (ORDER BY order_date) AS [moving_average_price]
FROM (
	SELECT
	DATETRUNC (year, order_date) AS [order_date],
	SUM (sales_amount) AS [total_sales],
	AVG (price) AS [avg_price]
	FROM fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC (year, order_date)
	)t