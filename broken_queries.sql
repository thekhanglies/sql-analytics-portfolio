-- PRACTICE FILE — broken_queries.sql
-- Each query below has 1-2 deliberate bugs. Fix them, then compare to the /queries folder.
-- ============================================================
-- BROKEN QUERY 1: Revenue by category
-- Bugs: 2
-- ============================================================

SELECT
    product_category_name,
    COUNT(order_id) AS num_orders,
    SUM(price + freight_value) AS total_revenue
FROM order_items
GROUP BY total_revenue
ORDER BY total_revenue DESC
LIMIT 15;


-- ============================================================
-- BROKEN QUERY 2: Delivery delay vs review score
-- Bugs: 2
-- ============================================================

SELECT
    CASE
        WHEN DATEDIFF('day', order_estimated_delivery_date, order_delivered_customer_date) <= 0 THEN 'On Time'
        WHEN DATEDIFF('day', order_estimated_delivery_date, order_delivered_customer_date) <= 3 THEN '1-3 Days Late'
        ELSE 'Over 3 Days Late'
    END AS delay_bucket,
    COUNT(*) AS num_orders,
    AVG(review_score) AS avg_review_score
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY delay_bucket
ORDER BY avg_review_score DESC;


-- ============================================================
-- BROKEN QUERY 3: Repeat purchase window function
-- Bugs: 2
-- ============================================================

SELECT
    customer_unique_id,
    order_id,
    order_purchase_timestamp,
    ROW_NUMBER() OVER (ORDER BY order_purchase_timestamp) AS order_rank
FROM orders o
JOIN customers c ON o.order_id = c.customer_id;


-- ============================================================
-- BROKEN QUERY 4: Multi-payment behavior
-- Bugs: 1
-- ============================================================

SELECT
    payment_type_count,
    COUNT(*) AS num_orders
FROM (
    SELECT
        order_id,
        COUNT(payment_type) AS payment_type_count
    FROM order_payments
    GROUP BY order_id
)
GROUP BY payment_type_count
ORDER BY payment_type_count;