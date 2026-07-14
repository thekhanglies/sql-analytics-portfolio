-- Question:   What does repeat purchase behavior look like?
-- Dataset:    Olist Brazilian E-Commerce (~100k orders, SQLite)
-- Techniques: CTE, ROW_NUMBER, PARTITION BY, JOIN, GROUP BY
-- Finding:    96% of 99k customers purchased exactly once — near-zero retention rate

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        o.order_id,
        o.order_purchase_timestamp,
        ROW_NUMBER() OVER (
            PARTITION BY c.customer_unique_id
            ORDER BY o.order_purchase_timestamp
        ) AS order_rank
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
)
SELECT
    order_rank,
    COUNT(*) AS num_customers
FROM customer_orders
GROUP BY order_rank
ORDER BY order_rank;