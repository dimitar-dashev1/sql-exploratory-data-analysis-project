-- Exploring all countries that customers come from
SELECT DISTINCT country
from dim_customers

-- Exploring the main product categories
SELECT DISTINCT
	category,
	subcategory,
	product_name
FROM dim_products
ORDER BY 1,2,3