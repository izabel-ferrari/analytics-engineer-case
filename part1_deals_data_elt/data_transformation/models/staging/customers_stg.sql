WITH customers AS (
    SELECT * FROM {{ source('raw_data', 'customers') }}
)

SELECT
    id AS customer_id,
    owner_id AS customer_owner_id,
    customer_name AS customer_name,
    customer_phase AS customer_phase,
    DATE(TIMESTAMP_SECONDS(CAST(start_date AS INT))) AS customer_start_date,
    end_date AS customer_end_date
FROM customers