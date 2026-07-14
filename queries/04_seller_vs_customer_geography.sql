-- Question:   Where are sellers concentrated vs. their customers?
-- Dataset:    Olist Brazilian E-Commerce (~100k orders, SQLite)
-- Techniques: 4-table JOIN, COUNT DISTINCT, NULLIF, CAST, GROUP BY
-- Finding:    São Paulo holds 1,849 sellers; other states significantly underserved

SELECT
    s.seller_state,
    COUNT(DISTINCT s.seller_id) AS num_sellers,
    COUNT(DISTINCT c.customer_unique_id) AS num_customers,
    ROUND(CAST(COUNT(DISTINCT c.customer_unique_id) AS REAL) /
          NULLIF(COUNT(DISTINCT s.seller_id), 0), 1) AS customers_per_seller
FROM order_items oi
JOIN sellers s ON oi.seller_id = s.seller_id
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY s.seller_state
ORDER BY num_sellers DESC;