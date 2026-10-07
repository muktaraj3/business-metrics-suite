-------------------- 3. Top-N Products per Category
WITH category_product_sales AS (
	SELECT 
		oi.product_category,
		oi.product_name,
		SUM(oi.quantity * oi.unit_price) AS total_sales,
		SUM(oi.quantity) AS units_sold
	FROM order_items oi
	JOIN orders o ON  oi.order_id = o.order_id 
	WHERE o.order_status = 'completed'
	GROUP BY oi.product_category, oi.product_name
),
ranked_products AS(
	SELECT 
		product_category,
		product_name,
		total_sales,
		units_sold,
		DENSE_RANK() OVER(PARTITION BY product_category ORDER BY total_sales DESC)AS sales_rank
	FROM category_product_sales
)
SELECT 
	product_category,
	sales_rank,
	product_name,
	total_sales,
	units_sold
FROM ranked_products
WHERE sales_rank <= 3
ORDER BY product_category, sales_rank;

