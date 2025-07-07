with 

source as (

    select * from {{ source('dbt_ex', 'raw_city') }}

)

select * from source
