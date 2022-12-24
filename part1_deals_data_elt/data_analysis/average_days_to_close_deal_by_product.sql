WITH deals AS (
  SELECT * FROM `analytics-engineer-case-372415.transformed_data_final.deals_fact`
)

SELECT
  deal_product,
  CAST(AVG(DATE_DIFF(deal_closed_date, deal_created_date, DAY)) AS INT) AS avg_days_to_close_deal
FROM deals
WHERE LOWER(deal_status) = 'closed'
GROUP BY deal_product
