-------------------- 1. Month-over-Month (MoM) Growth & Revenue Velocity
WITH monthly_revenue AS(
	SELECT
		DATE_TRUNC('month', order_date)::DATE AS sales_month,
		SUM (order_amount) AS total_revenue,
		COUNT(order_id)AS total_orders
	FROM orders 
	WHERE order_status = 'completed'
	GROUP BY DATE_TRUNC('month', order_date)
)

SELECT
	sales_month,
	total_revenue,
	LAG(total_revenue,1) OVER (ORDER BY sales_month) AS previous_month_revenue,
	ROUND((total_revenue - LAG(total_revenue,1) OVER (ORDER BY sales_month)) /
	NULLIF (LAG(total_revenue,1) OVER (ORDER BY sales_month),0)* 100, 2)
	AS mom_growth_pct
FROM monthly_revenue
ORDER BY sales_month;

