-- SNOWFLAKE PRACTICE — snowflake_tpch_practice.sql
-- Dataset: SNOWFLAKE_SAMPLE_DATA.TPCH_SF1 (built into Snowflake, no download needed)
-- Purpose: SQL fluency drills on clean synthetic data before moving to real Olist dataset
-- Concepts covered: SELECT, WHERE, JOIN, GROUP BY, HAVING, MAX, Window Functions

-- ============================================================
-- DAY 1 — First query. Proving the environment works.
-- ============================================================

SELECT * FROM customer LIMIT 10;


-- ============================================================
-- DAY 2 — SELECT + WHERE
-- Filtering rows before returning results
-- ============================================================

-- Return customers from nation 1 only
SELECT *
FROM customer
WHERE c_nationkey = 1;

-- Return customers whose account balance is above 5000, sorted descending
SELECT c_name, c_acctbal
FROM customer
WHERE c_acctbal > 5000
ORDER BY c_acctbal DESC;


-- ============================================================
-- DAY 3 — JOINs (INNER + LEFT)
-- Connecting two tables via a shared key
-- ============================================================

-- INNER JOIN: customer orders — only customers who have placed orders
SELECT c.c_name, o.o_orderdate, o.o_totalprice
FROM customer c
JOIN orders o ON c.c_custkey = o.o_custkey
LIMIT 10;

-- LEFT JOIN variant: keeps all customers even if they have no orders
-- (rows with no match return NULL in order columns)
SELECT c.c_name, o.o_orderdate, o.o_totalprice
FROM customer c
LEFT JOIN orders o ON c.c_custkey = o.o_custkey
LIMIT 10;


-- ============================================================
-- DAY 4 — GROUP BY + HAVING
-- Aggregating into buckets, then filtering on those buckets
-- ============================================================

-- Total orders and spend per nation — only nations with more than 50 orders
SELECT
    c.c_nationkey,
    COUNT(*) AS num_orders,
    SUM(o.o_totalprice) AS total_spent
FROM customer c
JOIN orders o ON c.c_custkey = o.o_custkey
GROUP BY c.c_nationkey
HAVING COUNT(*) > 50
ORDER BY total_spent DESC;


-- ============================================================
-- DAY 4 — MAX() — one argument only
-- Common mistake: MAX() takes one column, not two
-- ============================================================

-- WRONG (syntax error — MAX takes one argument):
-- SELECT MAX(l_quantity, l_extendedprice) FROM LINEITEM GROUP BY l_linenumber;

-- CORRECT: two separate MAX() calls
SELECT
    l_linenumber,
    MAX(l_quantity) AS max_qty,
    MAX(l_extendedprice) AS max_price
FROM LINEITEM
GROUP BY l_linenumber;


-- ============================================================
-- DAY 6 — Window Functions: ROW_NUMBER + PARTITION BY
-- Assigns a row number per group without collapsing rows
-- ============================================================

-- Number each customer's orders chronologically
-- PARTITION BY resets the counter for each new customer
SELECT
    o_custkey,
    o_orderdate,
    o_totalprice,
    ROW_NUMBER() OVER (
        PARTITION BY o_custkey
        ORDER BY o_orderdate
    ) AS order_num
FROM orders
ORDER BY o_custkey, o_orderdate
LIMIT 20;

-- What PARTITION BY does:
-- Without it: 1, 2, 3, 4, 5... (global count)
-- With PARTITION BY o_custkey:
--   Customer A: 1, 2, 3
--   Customer B: 1, 2
--   Customer C: 1, 2, 3, 4
-- It resets the counter every time the customer changes.
