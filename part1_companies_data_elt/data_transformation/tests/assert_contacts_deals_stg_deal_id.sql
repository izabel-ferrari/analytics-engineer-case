WITH contacts_deals_associations AS (
    SELECT * FROM {{ ref('contacts_deals_associations_stg') }}
), deals AS (
    SELECT * FROM {{ ref('deals_stg') }}
)

SELECT
    deal_id
FROM deals
WHERE deal_id NOT IN (
    SELECT
        deal_id
    FROM contacts_deals_associations
)