-- 1. Null audit — how incomplete is the dataset?
SELECT
    COUNT(*) AS total_orders,
    SUM(CASE WHEN order_delivered_customer_date IS NULL THEN 1 ELSE 0 END) AS missing_delivery_date,
    SUM(CASE WHEN order_approved_at IS NULL THEN 1 ELSE 0 END) AS missing_approval_date,
    ROUND(SUM(CASE WHEN order_delivered_customer_date IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_missing_delivery
FROM orders;

-- 2. Duplicate check — are any order_ids repeated?
SELECT order_id, COUNT(*) AS occurrences
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- 3. Price sanity check — any zero or negative prices?
SELECT
    COUNT(*) AS total_items,
    SUM(CASE WHEN price <= 0 THEN 1 ELSE 0 END) AS zero_or_negative_price,
    SUM(CASE WHEN freight_value < 0 THEN 1 ELSE 0 END) AS negative_freight
FROM order_items;

-- 4. Date logic check — any orders delivered before they were placed?
SELECT COUNT(*) AS impossible_orders
FROM orders
WHERE order_delivered_customer_date < order_purchase_timestamp;