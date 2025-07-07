with 

source as (

    select * from {{ source('dbt_ex', 'raw_city') }}

),

renamed as (

    select

    from source

)

select * from renamed
