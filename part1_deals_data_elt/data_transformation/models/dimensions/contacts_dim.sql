WITH contacts AS (
    SELECT * FROM {{ ref ('contacts_stg') }}
)

SELECT
    contacts.contact_id AS contact_id,
    contacts.contact_job AS contact_job,
    contacts.contact_country AS contact_country,
    contacts.contact_channel AS contact_channel
FROM contacts