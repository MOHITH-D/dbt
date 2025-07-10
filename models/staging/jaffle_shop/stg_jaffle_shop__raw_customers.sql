with 

source as (

    select * from {{ source('jaffle_shop', 'raw_customers') }}

),

renamed as (

    select
        id,
        name

    from source

)

select * from renamed
