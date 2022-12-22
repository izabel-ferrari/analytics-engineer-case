SELECT
    id AS company_id,
    name AS company_name,
    CASE
        WHEN UPPER(country) = 'BRA' THEN 'BR'
        ELSE UPPER(country)
    END AS company_country
FROM {{ source('raw_data', 'companies') }}