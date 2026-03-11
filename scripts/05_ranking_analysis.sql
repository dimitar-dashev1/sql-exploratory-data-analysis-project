-- What are the top 5 products that generate the highest revenue
SELECT *
FROM (
	SELECT
	p.product_name,
	SUM (f.sales_amount) AS [total_revenue],
	ROW_NUMBER () OVER (ORDER BY SUM (f.sales_amount) DESC) AS [product_rank]
	FROM fact_sales AS [f]
	LEFT JOIN dim_products AS [p]
	ON p.product_key = f.product_key
	GROUP BY p.product_name)t
WHERE product_rank <= 5

-- What are the 5 worst-performing subcategories of products by sales
SELECT TOP 5
	p.subcategory,
	SUM (f.sales_amount) AS [total_revenue]
FROM fact_sales AS [f]
LEFT JOIN dim_products AS [p]
ON p.product_key = f.product_key
GROUP BY p.subcategory
ORDER BY total_revenue ASC

-- Finding the top 10 customers who have generated the highest revenue
SELECT TOP 10
	c.customer_key,
	c.first_name,
	c.last_name,
	SUM (f.sales_amount) AS [total_revenue]
FROM fact_sales AS [f]
LEFT JOIN dim_customers AS [c]
ON c.customer_key = f.customer_key
GROUP BY
	c.customer_key,
	c.first_name,
	c.last_name
ORDER BY total_revenue DESC

-- Finding the bottom 3 customers by number of orders placed
SELECT TOP 3
	c.customer_key,
	c.first_name,
	c.last_name,
	COUNT (DISTINCT f.order_number) AS [total_orders]
FROM fact_sales AS [f]
LEFT JOIN dim_customers AS [c]
ON c.customer_key = f.customer_key
GROUP BY
	c.customer_key,
	c.first_name,
	c.last_name
ORDER BY total_orders