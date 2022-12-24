WITH contacts_deals_associations AS (
    SELECT * FROM {{ ref('contacts_deals_associations_stg') }}
), contacts AS (
    SELECT * FROM {{ ref('contacts_stg') }}
)

SELECT
    contact_id
FROM contacts
WHERE contact_id NOT IN (
    SELECT
        contact_id
    FROM contacts_deals_associations
)