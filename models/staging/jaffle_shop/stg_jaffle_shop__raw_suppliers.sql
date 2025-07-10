with 

source as (

    select * from {{ source('jaffle_shop', 'raw_suppliers') }}

),

renamed as (

    select
        id,
        name,
        cost,
        perishable,
        sku

    from source

)

select * from renamed
