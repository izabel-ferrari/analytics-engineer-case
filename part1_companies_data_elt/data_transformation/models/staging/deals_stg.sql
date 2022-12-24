SELECT
    id AS deal_id,
    ownerId AS deal_owner_id,
    name AS deal_name,
    product AS deal_product,
    amount AS deal_amount,
    status AS deal_status,
    CAST(created_date AS DATE) AS deal_created_date,
    CAST(closed_9 AS DATE) AS deal_closed_date
FROM {{ source('raw_data', 'deals') }}