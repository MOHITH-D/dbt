{{
    config(
        materialized='incremental',
        unique_key='c_custkey'
    )
}}

with source_data as(
select *,current_timestamp as last_updated 
from {{ ref('stg_dbt_ex__customer') }}
)

select * from source_data

{% if is_incremental() %}
 where c_custkey > (select max(c_custkey) from {{ this }}) 
{% endif %}
