/* 1. Finding out the date of the first and last order
2. How many years of sales are available */
SELECT
	MIN (order_date) AS [first_order_date],
	MAX (order_date) AS [latest_order_date],
	DATEDIFF(year, MIN (order_date), MAX (order_date)) AS [order_range_years]
from fact_sales

-- Finding the youngest and oldest customer
SELECT
	MIN (birthdate) AS [oldest_birthdate],
	DATEDIFF (year, MIN(birthdate), GETDATE()) AS [oldest_age],
	MAX (birthdate) AS [youngest_birthdate],
	DATEDIFF (year, MAX(birthdate), GETDATE()) AS [youngest_age]
FROM dim_customers