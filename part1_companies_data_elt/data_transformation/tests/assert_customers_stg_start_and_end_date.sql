WITH customers AS (
    SELECT * FROM {{ ref('customers_stg') }}
)

SELECT
    customer_id,
    customer_start_date,
    customer_end_date
FROM customers
WHERE DATE_DIFF(customer_end_date, customer_start_date, DAY) < 0