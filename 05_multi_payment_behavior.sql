-- Question:   What does multi-payment behavior look like?
-- Dataset:    Olist Brazilian E-Commerce (~100k orders, SQLite)
-- Techniques: Subquery, COUNT DISTINCT, GROUP BY, AVG, ROUND
-- Finding:    97% of orders used one payment method — Brazil's installment culture reduces split payments

SELECT
    payment_type_count,
    COUNT(*) AS num_orders,
    ROUND(AVG(total_payment_value), 2) AS avg_order_value
FROM (
    SELECT
        order_id,
        COUNT(DISTINCT payment_type) AS payment_type_count,
        SUM(payment_value) AS total_payment_value
    FROM order_payments
    GROUP BY order_id
) AS payment_summary   -- SQLite requires alias on subqueries
GROUP BY payment_type_count
ORDER BY payment_type_count;