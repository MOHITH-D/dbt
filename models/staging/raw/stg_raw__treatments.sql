{{
    config(
        schema='staging',
        tags='treatments'
    )
}}
with 

source as (

    select * from {{ source('raw', 'treatments') }}

),

renamed as (

    select
        treatment_id,
        appointment_id,
        treatment_type,
        description,
        cost,
        treatment_date,
        created_at

    from source

)

select * from renamed
