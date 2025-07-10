with 

source as (

    select * from {{ source('jaffle_shop', 'raw_Items') }}

),

renamed as (

    select
        id,
        order_id,
        sku

    from source

)

select * from renamed
