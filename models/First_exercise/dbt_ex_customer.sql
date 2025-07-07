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

-- changed_records as (
--     select src.* from source_data src
--     left join {{this}} tgt on src.c_custkey=tgt.c_custkey
--     where 
--         tgt.c_custkey is NULL
--         or (
--             src.c_name <> tgt.c_name or
--             src.c_address <> tgt.c_address OR
--             src.c_nationkey <> tgt.c_nationkey or
--             src.c_phone <> tgt.c_phone or
--             src.c_acctbal <> tgt.c_acctbal or
--             src.c_mktsegment <> tgt.c_mktsegment or
--             src.c_comment <> tgt.c_comment
--         )
-- )
-- select * from changed_records