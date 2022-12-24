WITH deals AS (
  SELECT * FROM `analytics-engineer-case-372415.transformed_data_final.deals_fact`
),
deals_month_product AS (
  SELECT
    FORMAT_DATE('%Y-%m', deal_created_date) AS deal_created_month,
    CASE deal_product
      WHEN 'Data Aggregation' THEN 'data_aggregation'
      WHEN 'Data Enrichment' THEN 'data_enrichment'
      ELSE lower(deal_product)
    END AS deal_product,
    deal_amount,
  FROM deals
  WHERE LOWER(deal_status) = 'closed'
)

SELECT * FROM (
  SELECT
    deal_created_month,
    deal_product,
    deal_amount
  FROM deals_month_product
)
PIVOT (
  SUM(deal_amount) FOR deal_product IN ('data_aggregation', 'data_enrichment', 'payments')
)
ORDER BY deal_created_month
