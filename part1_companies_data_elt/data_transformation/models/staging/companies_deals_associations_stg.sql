WITH tmp AS (
  SELECT companyId AS company_id,
  SPLIT(REPLACE(REPLACE(dealIds, '[', ''), ']', ''), ', ') AS deal_id_array
FROM {{ source('raw_data', 'companies_deals_associations') }}
)

SELECT
    company_id,
    CAST(deal_id AS INT) AS deal_id
FROM tmp
CROSS JOIN UNNEST(deal_id_array) AS deal_id