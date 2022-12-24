WITH companies_deals_associations AS (
    SELECT * FROM {{ ref('companies_deals_associations_stg') }}
), companies AS (
    SELECT * FROM {{ ref('companies_stg') }}
)

SELECT
    company_id
FROM companies
WHERE company_id NOT IN (
    SELECT
        company_id
    FROM companies_deals_associations
)