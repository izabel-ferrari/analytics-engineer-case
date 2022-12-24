WITH contacts AS (
  SELECT * FROM `analytics-engineer-case-372415.transformed_data_final.contacts_dim`
),
deals AS (
  SELECT * FROM `analytics-engineer-case-372415.transformed_data_final.deals_fact`
)

SELECT
  contact_channel,
  COUNT(*) as closed_deals_qty,
  SUM(deal_amount) AS closed_deal_amt
FROM deals
LEFT JOIN contacts
  ON deals.deal_contact_id = contacts.contact_id
WHERE LOWER(deal_status) = 'closed'
GROUP BY 1
ORDER BY 2 DESC, 3 DESC