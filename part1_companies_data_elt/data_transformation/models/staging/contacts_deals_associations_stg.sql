WITH contacts_deals_associations AS (
    SELECT * FROM {{ source('raw_data', 'contacts_deals_associations') }}
), tmp AS (
  SELECT contactId AS contact_id,
  SPLIT(REPLACE(REPLACE(dealIds, '[', ''), ']', ''), ', ') AS deal_id_array
FROM contacts_deals_associations
)

SELECT
    contact_id,
    CAST(deal_id AS INT) AS deal_id
FROM tmp
CROSS JOIN UNNEST(deal_id_array) AS deal_id