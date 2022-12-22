SELECT
    id AS company_id,
    name AS company_name,
    CASE UPPER(country)
        WHEN 'BRAZIL' THEN 'BR'
        WHEN 'BRASIL' THEN 'BR'
        WHEN 'BRA' THEN 'BR'
        WHEN 'MEXICO' THEN 'MX'
        WHEN 'MÉXICO' THEN 'MX'
        WHEN 'MEX' THEN 'MX'
        WHEN 'COLOMBIA' THEN 'CO'
        WHEN 'COL' THEN 'CO'
        ELSE UPPER(country)
    END AS company_country
FROM {{ source('raw_data', 'companies') }}