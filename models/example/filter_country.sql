SELECT *
FROM {{ ref('stg_dbt_ex__nation') }}
WHERE n_regionkey= {{ var("target_country") }}