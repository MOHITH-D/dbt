{{
    config(
        materialized='incremental',
        unique_key='c_custkey',
        incremental_strategy='merge'
    )
}}

with source_data1 as(
    select * 
    from {{ source('updated_timestamp', 'dbt_ex_customer') }} 
    where last_updated >= current_timestamp - INTERVAl '7 day'
)
select * from source_data1 s
{% if is_incremental() %}
    where s.c_custkey NOT IN (SELECT c_custkey FROM {{ this }} WHERE last_updated >= s.last_updated)
{% endif %}