WITH row_count_stg AS (
    SELECT COUNT(*) AS row_cnt, 'companies' AS table_nm FROM {{ ref('companies_stg') }} UNION ALL
    SELECT COUNT(*) AS row_cnt, 'contacts' AS table_nm FROM {{ ref('contacts_stg') }} UNION ALL
    SELECT COUNT(*) AS row_cnt, 'customers' AS table_nm FROM {{ ref('customers_stg') }} UNION ALL
    SELECT COUNT(*) AS row_cnt, 'owners' AS table_nm FROM {{ ref('owners_stg') }} UNION ALL
    SELECT COUNT(*) AS row_cnt, 'deals' AS table_nm FROM {{ ref('deals_stg') }}
), row_count_final AS (
    SELECT COUNT(*) AS row_cnt, 'companies' AS table_nm FROM {{ ref('companies_dim') }} UNION ALL
    SELECT COUNT(*) AS row_cnt, 'contacts' AS table_nm FROM {{ ref('contacts_dim') }} UNION ALL
    SELECT COUNT(*) AS row_cnt, 'customers' AS table_nm FROM {{ ref('customers_dim') }} UNION ALL
    SELECT COUNT(*) AS row_cnt, 'owners' AS table_nm FROM {{ ref('owners_dim') }} UNION ALL
    SELECT COUNT(*) AS row_cnt, 'deals' AS table_nm FROM {{ ref('deals_fact') }}
)

SELECT
    stg.table_nm AS table_nm,
    stg.row_cnt AS stg_row_cnt,
    final.row_cnt AS final_row_cnt
FROM row_count_stg stg
INNER JOIN row_count_final final
    ON stg.table_nm = final.table_nm
WHERE stg.row_cnt <> final.row_cnt