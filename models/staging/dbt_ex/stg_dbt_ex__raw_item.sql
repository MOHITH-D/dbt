with 

source as (

    select * from {{ source('dbt_ex', 'raw_item') }}

)

select * from source
