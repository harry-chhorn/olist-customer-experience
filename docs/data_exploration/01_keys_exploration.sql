DESCRIBE orders;

DESCRIBE customers;

DESCRIBE sellers
-- Data typs is fine.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS distinct_keys
FROM
    orders;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS distinct_keys
FROM
    customers;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT seller_id) AS distinct_keys
FROM
    sellers;

-- order_id, customer_id, and seller_id are primary keys
-- in their tables.
SELECT
    order_id,
    order_item_id,
    product_id,
    price
FROM
    order_items
WHERE
    order_id IN (
        SELECT
            order_id
        FROM
            order_items
        GROUP BY
            order_id
        HAVING
            COUNT(*) > 2
        LIMIT
            1
    );

SELECT
    (
        SELECT
            COUNT(*)
        FROM
            order_items
    ) AS total_rows,
    (
        SELECT
            COUNT(*)
        FROM
            (
                SELECT DISTINCT
                    order_id,
                    order_item_id
                FROM
                    order_items
            )
    ) AS distinct_pairs;

-- order_items tables has a composite primary key of (order_id, order_item_id)
SELECT
    (
        SELECT
            COUNT(*)
        FROM
            order_payments
    ) AS total,
    (
        SELECT
            COUNT(*)
        FROM
            (
                SELECT DISTINCT
                    order_id,
                    payment_sequential
                FROM
                    order_payments
            )
    ) AS dis;

-- order_payments tables has a composite primary key of (order_id, payment_sequential)