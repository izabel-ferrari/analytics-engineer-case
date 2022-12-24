WITH companies AS (
    SELECT * FROM {{ ref ('companies_stg') }}
)

SELECT
    companies.company_id AS company_id,
    companies.company_name AS company_name,
    companies.company_country AS company_country
FROM companies