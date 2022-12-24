WITH deals AS (
    SELECT * FROM {{ ref ('deals_stg') }}
), companies_deals_associations AS (
    SELECT * FROM {{ ref ('companies_deals_associations_stg') }}
), contacts_deals_associations AS (
    SELECT * FROM {{ ref ('contacts_deals_associations_stg') }}
)
SELECT
    deals.deal_id AS deal_id,
    deals.deal_owner_id AS deal_owner_id,
    companies_deals_associations.company_id AS deal_company_id,
    contacts_deals_associations.contact_id AS deal_contact_id,
    deals.deal_name AS deal_name,
    deals.deal_product AS deal_product,
    deals.deal_amount AS deal_amount,
    deals.deal_status AS deal_status,
    deals.deal_created_date AS deal_created_date,
    deals.deal_closed_date AS deal_closed_date
FROM deals
LEFT JOIN companies_deals_associations
    ON deals.deal_id = companies_deals_associations.company_id
LEFT JOIN contacts_deals_associations
    ON deals.deal_id = contacts_deals_associations.contact_id