WITH companies AS (
  SELECT * FROM `analytics-engineer-case-372415.transformed_data_final.companies_dim`
),
deals AS (
  SELECT * FROM `analytics-engineer-case-372415.transformed_data_final.deals_fact`
)

SELECT
  company_name,
  COUNT(*) as closed_deals_qty,
  SUM(deal_amount) AS closed_deal_amt
FROM deals
LEFT JOIN companies
  ON deals.deal_company_id = companies.company_id
WHERE LOWER(deal_status) = 'closed'
GROUP BY 1
HAVING COUNT(*) > 1
ORDER BY 2 DESC, 3 DESC