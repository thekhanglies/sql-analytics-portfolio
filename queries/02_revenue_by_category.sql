-- Question:   Which product categories drive the most revenue?
-- Dataset:    Olist Brazilian E-Commerce (~100k orders, SQLite)
-- Techniques: JOIN, GROUP BY, SUM, COUNT DISTINCT, ORDER BY
-- Finding:    Beauty & health led at $1.44M; watches & gifts had highest avg price at $201

SELECT
    p.product_category_name,
    COUNT(DISTINCT oi.order_id) AS num_orders,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue,
    ROUND(AVG(oi.price), 2) AS avg_item_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 15;