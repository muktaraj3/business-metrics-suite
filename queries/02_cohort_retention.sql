-------------------- 2. Customer Cohort Retention Analysis
WITH customer_cohorts AS (
    SELECT 
        customer_id,
        DATE_TRUNC('month', signup_date)::DATE AS cohort_month
    FROM customers
),
customer_activities AS (
    SELECT 
        o.customer_id,
        DATE_TRUNC('month', o.order_date)::DATE AS activity_month
    FROM orders o
    WHERE o.order_status = 'completed'
    GROUP BY o.customer_id, DATE_TRUNC('month', o.order_date)
),
cohort_size AS (
    SELECT 
        cohort_month,
        COUNT(DISTINCT customer_id) AS total_users
    FROM customer_cohorts
    GROUP BY cohort_month            
)
SELECT 
    c.cohort_month,
    s.total_users AS cohort_base,
    (
        (EXTRACT(YEAR FROM a.activity_month) - EXTRACT(YEAR FROM c.cohort_month)) * 12 +
        (EXTRACT(MONTH FROM a.activity_month) - EXTRACT(MONTH FROM c.cohort_month))
    )::INT AS month_number,
    COUNT(DISTINCT a.customer_id) AS active_users,
    ROUND(COUNT(DISTINCT a.customer_id)::NUMERIC / s.total_users * 100, 1) AS retention_rate_pct
FROM customer_cohorts c
JOIN customer_activities a ON c.customer_id = a.customer_id
JOIN cohort_size s ON c.cohort_month = s.cohort_month   -- Fixed: alias 's' and join on 'c'
GROUP BY 
    c.cohort_month, 
    s.total_users, 
    (
        (EXTRACT(YEAR FROM a.activity_month) - EXTRACT(YEAR FROM c.cohort_month)) * 12 +
        (EXTRACT(MONTH FROM a.activity_month) - EXTRACT(MONTH FROM c.cohort_month))
    )
ORDER BY c.cohort_month, month_number;

