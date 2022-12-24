WITH contacts AS (
    SELECT * FROM {{ source('raw_data', 'contacts') }}
)

SELECT
    id AS contact_id,
    -- name AS contact_name, -- as this field contains personal data, it is advisable to either mask or remove it
    job AS contact_job,
    CASE
        WHEN UPPER(country) IN ('BRAZIL', 'BRASIL', 'BRA') THEN 'BR'
        WHEN UPPER(country) IN ('MEXICO', 'MÉXICO', 'MEX') THEN 'MX'
        WHEN UPPER(country) IN ('COLOMBIA', 'COL') THEN 'CO'
        ELSE UPPER(country)
    END AS contact_country,
    channel AS contact_channel
FROM contacts