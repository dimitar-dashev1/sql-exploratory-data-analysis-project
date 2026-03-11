/* Analyzing the yearly performance of products by comparing their sales
to both the product’s average sales and its previous year’s (YoY) sales */
WITH yearly_product_sales AS
(
	SELECT
	YEAR (f.order_date) AS [order_year],
	p.product_name,
	SUM (f.sales_amount) AS [current_sales]
	FROM fact_sales AS [f]
	LEFT JOIN dim_products AS [p]
	ON f.product_key = p.product_key
	WHERE f.order_date IS NOT NULL
	GROUP BY YEAR (f.order_date), p.product_name
)
SELECT
	order_year,
	product_name,
	current_sales,
	AVG (current_sales) OVER (PARTITION BY product_name) AS [avg_sales],
	current_sales - AVG (current_sales) OVER (PARTITION BY product_name) AS [dev_from_avg],
	CASE WHEN current_sales - AVG (current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above average'
		 WHEN current_sales - AVG (current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below average'
		 ELSE 'Average'
	END AS [avg_change],
	LAG (current_sales) OVER (PARTITION BY product_name ORDER BY order_year ASC) AS [prev_year_sales],
	current_sales - LAG (current_sales) OVER (PARTITION BY product_name ORDER BY order_year ASC) AS [YoY_sales],
	CASE WHEN current_sales - LAG (current_sales) OVER (PARTITION BY product_name ORDER BY order_year ASC) > 0 THEN 'Increase'
		 WHEN current_sales - LAG (current_sales) OVER (PARTITION BY product_name ORDER BY order_year ASC) < 0 THEN 'Decrease'
		 ELSE 'No change'
	END AS [avg_change_YoY]
FROM yearly_product_sales
ORDER BY product_name, order_year