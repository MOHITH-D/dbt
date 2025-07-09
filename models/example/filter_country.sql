SELECT *
FROM {{ ref('stg_dbt_ex__nation') }}
WHERE n_name = '{{ var("target_country") }}'
