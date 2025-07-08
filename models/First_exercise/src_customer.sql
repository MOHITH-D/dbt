with source_data as(
select *,current_timestamp as last_updated 
from {{ ref('stg_dbt_ex__customer') }}
)

select * from source_data