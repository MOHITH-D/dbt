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
        treatment_date

    from source

)

select * from renamed
