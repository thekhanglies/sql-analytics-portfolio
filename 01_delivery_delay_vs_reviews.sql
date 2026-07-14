-- Question:   Does delivery delay predict lower review scores?
-- Dataset:    Olist Brazilian E-Commerce (~100k orders, SQLite)
-- Techniques: JOIN, JULIANDAY, CASE, GROUP BY, AVG
-- Finding:    On-time orders averaged 4.29 stars vs 1.73 for orders 7+ days late

SELECT
    CASE
        WHEN JULIANDAY(o.order_delivered_customer_date)
           - JULIANDAY(o.order_estimated_delivery_date) <= 0 THEN 'On Time'
        WHEN JULIANDAY(o.order_delivered_customer_date)
           - JULIANDAY(o.order_estimated_delivery_date) <= 3 THEN '1-3 Days Late'
        WHEN JULIANDAY(o.order_delivered_customer_date)
           - JULIANDAY(o.order_estimated_delivery_date) <= 7 THEN '4-7 Days Late'
        ELSE 'Over 1 Week Late'
    END AS delay_bucket,
    COUNT(*) AS num_orders,
    ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM orders o
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY delay_bucket
ORDER BY avg_review_score DESC;