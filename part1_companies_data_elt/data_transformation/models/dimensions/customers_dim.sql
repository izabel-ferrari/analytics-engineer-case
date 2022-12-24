WITH customers AS (
    SELECT * FROM {{ ref ('customers_stg') }}
)

SELECT
    customers.customer_id AS customer_id,
    customers.customer_owner_id AS customer_owner_id,
    customers.customer_name AS customer_name,
    customers.customer_phase AS customer_phase,
    customers.customer_start_date AS customer_start_date,
    customers.customer_end_date AS customer_end_date
FROM customers