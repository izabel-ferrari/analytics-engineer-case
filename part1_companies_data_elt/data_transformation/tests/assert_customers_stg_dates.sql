WITH customers_dates AS (
    SELECT customer_id, customer_start_date, customer_end_date FROM {{ ref('customers_stg') }}
)
SELECT
    customer_id,
    customer_start_date,
    customer_end_date
FROM customers_dates
WHERE DATE_DIFF(customer_end_date, customer_start_date, DAY) < 0