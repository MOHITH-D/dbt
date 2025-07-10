with 

source as (

    select * from {{ source('jaffle_shop', 'raw_products') }}

),

renamed as (

    select
        sku,
        name,
        type,
        price,
        description

    from source

)

select * from renamed
