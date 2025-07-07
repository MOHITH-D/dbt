{{ 
    config(
        materialized='ephemeral'
    )
}}
SELECT
  *
FROM {{ source('dbt_ex', 'customer') }}

