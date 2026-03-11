-- Finding the total sales amount
SELECT
	SUM (sales_amount) as [total_sales]
FROM fact_sales

-- Finding out how many items were sold
SELECT
	SUM (quantity) AS [total_sales_qty]
FROM fact_sales

-- Finding the average selling price
SELECT
	AVG (price) AS [avg_price]
FROM fact_sales

-- Finding the total number of orders
SELECT
	COUNT (DISTINCT order_number) AS [total_orders]
FROM fact_sales

-- Finding the total number of products
SELECT
	COUNT (DISTINCT product_key) AS [total_products]
FROM dim_products

-- Finding the total number of customers
SELECT
	COUNT (customer_key) AS [total_customers]
FROM dim_customers

-- Finding the total number of customers that have placed an order
SELECT
	COUNT (DISTINCT customer_key) AS [total_customers_ordered]
FROM fact_sales

-- Combining the information into a report that shows all key metrics of the business
SELECT
	'Total Sales' AS [measure_name],
	SUM (sales_amount) AS [measure_value]
FROM fact_sales
UNION ALL
SELECT 
	'Total Quantity',
	SUM (quantity)
FROM fact_sales
UNION ALL
SELECT 
	'Average Price',
	AVG (price)
FROM fact_sales
UNION ALL
SELECT 
	'Total Nr. Orders',
	COUNT (DISTINCT order_number)
FROM fact_sales
UNION ALL
SELECT 
	'Total Nr. Products',
	COUNT (product_name)
FROM dim_products
UNION ALL
SELECT 
	'Total Nr. Customers',
	COUNT (customer_key)
FROM dim_customers