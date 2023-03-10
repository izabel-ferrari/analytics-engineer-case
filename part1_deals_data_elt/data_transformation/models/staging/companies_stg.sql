WITH companies AS (
    SELECT * FROM {{ source('raw_data', 'companies') }}
)

SELECT
    id AS company_id,
    name AS company_name,
    CASE
        WHEN UPPER(country) IN ('BRAZIL', 'BRASIL', 'BRA') THEN 'BR'
        WHEN UPPER(country) IN ('MEXICO', 'MÉXICO', 'MEX') THEN 'MX'
        WHEN UPPER(country) IN ('COLOMBIA', 'COL') THEN 'CO'
        ELSE UPPER(country)
    END AS company_country
FROM companies