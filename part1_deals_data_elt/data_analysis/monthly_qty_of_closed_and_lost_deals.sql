WITH deals AS (
  SELECT * FROM `analytics-engineer-case-372415.transformed_data_final.deals_fact`
),
deals_month_product AS (
  SELECT
    FORMAT_DATE('%Y-%m', deal_created_date) AS deal_created_month,
    lower(deal_status) AS deal_status
  FROM deals
)

SELECT * FROM (
  SELECT
    deal_created_month,
    deal_status
  FROM deals_month_product
)
PIVOT (
  COUNT(*) FOR deal_status IN ('closed', 'lost')
)
ORDER BY deal_created_month
