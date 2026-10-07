--------------------- 5. RFM(Recency, Frequency, Monetary) Customer Segmentation
WITH rfm_base AS (
	SELECT 
		c.customer_id,
		c.customer_name,
		-------------- RECENCY----------------
		('2024-04-01' :: DATE - MAX(o.order_date)) AS recency_days,
		-------------- FREQUENCY----------------
		COUNT(o.order_id) AS frequency_count,
		-------------- MONETARY----------------
		COALESCE (SUM(o.order_amount),0) AS total_monetary_spend
	FROM customers c
	LEFT JOIN orders o
			ON c.customer_id = o.customer_id
			AND o.order_status = 'completed'
	GROUP BY c.customer_id, c.customer_name
),
rfm_scores AS(
SELECT 
	customer_id,
	customer_name,
	recency_days,
	frequency_count,
	total_monetary_spend,
	NTILE(4) OVER (ORDER BY recency_days ASC) AS r_score,
	NTILE(4) OVER (ORDER BY frequency_count DESC) AS f_score,
	NTILE(4) OVER (ORDER BY total_monetary_spend DESC) AS m_score
FROM rfm_base
)
SELECT 
	customer_id,
	customer_name,
	recency_days,
	frequency_count,
	total_monetary_spend,
	CONCAT(r_score,'-', f_score, '-', m_score) AS rfm_cell,
	CASE 
		WHEN r_score >= 3 AND f_score >= 3 THEN 'High-Value Loyal'
		WHEN r_score <= 2 AND f_score >= 3 THEN 'At-Risk/Lapsed'
		WHEN r_score >= 3 AND f_score <= 2 THEN 'New/Recent Activations'
		ELSE 'Low Engagement/Dormant' 
	END AS customer_segment
FROM rfm_scores
ORDER BY total_monetary_spend DESC;
