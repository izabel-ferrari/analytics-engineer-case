WITH deals AS (
  SELECT * FROM `analytics-engineer-case-372415.transformed_data_final.deals_fact`
), deal_created_closed AS (
  SELECT
    deal_product,
    deal_created_date,
    deal_closed_date,
    DATE_DIFF(deal_closed_date, deal_created_date, DAY) AS days_until_deal_closed
  FROM deals
  WHERE LOWER(deal_status) = 'closed'
)
SELECT
  deal_product,
  CAST(AVG(days_until_deal_closed) AS INT) AS avg_days_until_deal_closed
FROM deal_created_closed
GROUP BY deal_product
