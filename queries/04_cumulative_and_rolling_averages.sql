--------------------------- 4. Running Cumulative Revenue & oving Averages
WITH daily_sales AS (
	SELECT 
		order_date,
		SUM(order_amount) AS daily_revenue 
	FROM orders 
	WHERE  order_status= 'completed'
	GROUP BY  order_date
)
SELECT 
	order_date,
	daily_revenue,
	------------- Runnig Cumulative Total
	SUM(daily_revenue) OVER(
						ORDER BY order_date
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	) AS cumulative_revenue,
	------------- 7-Day Rolling Moving Average
	ROUND(
		AVG (daily_revenue) OVER (
								ORDER BY order_date
						        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
		),2
	)AS rolling_7day_avg_revenue
FROM daily_sales
ORDER BY order_date;

