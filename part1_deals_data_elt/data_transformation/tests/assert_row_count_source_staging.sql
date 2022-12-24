WITH row_count_raw AS (
    SELECT COUNT(*) AS row_cnt, 'companies' AS table_nm FROM {{ source('raw_data', 'companies') }} UNION ALL
    SELECT COUNT(*) AS row_cnt, 'contacts' AS table_nm FROM {{ source('raw_data', 'contacts') }} UNION ALL
    SELECT COUNT(*) AS row_cnt, 'customers' AS table_nm FROM {{ source('raw_data', 'customers') }} UNION ALL
    SELECT COUNT(*) AS row_cnt, 'owners' AS table_nm FROM {{ source('raw_data', 'owners') }} UNION ALL
    SELECT COUNT(*) AS row_cnt, 'deals' AS table_nm FROM {{ source('raw_data', 'deals') }}
), row_count_stg AS (
    SELECT COUNT(*) AS row_cnt, 'companies' AS table_nm FROM {{ ref('companies_stg') }} UNION ALL
    SELECT COUNT(*) AS row_cnt, 'contacts' AS table_nm FROM {{ ref('contacts_stg') }} UNION ALL
    SELECT COUNT(*) AS row_cnt, 'customers' AS table_nm FROM {{ ref('customers_stg') }} UNION ALL
    SELECT COUNT(*) AS row_cnt, 'owners' AS table_nm FROM {{ ref('owners_stg') }} UNION ALL
    SELECT COUNT(*) AS row_cnt, 'deals' AS table_nm FROM {{ ref('deals_stg') }}
)

SELECT
    stg.table_nm AS table_nm,
    stg.row_cnt AS stg_row_cnt,
    raw.row_cnt AS raw_row_cnt
FROM row_count_stg stg
INNER JOIN row_count_raw raw
    ON stg.table_nm = raw.table_nm
WHERE stg.row_cnt <> raw.row_cnt