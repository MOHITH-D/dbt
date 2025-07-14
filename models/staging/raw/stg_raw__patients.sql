{{
    config(
        schema='staging'
    )
}}
with 

source as (

    select * from {{ source('raw', 'patients') }}

),

renamed as (

    select
        patient_id,
        first_name,
        last_name,
        gender,
        date_of_birth,
        contact_number,
        address,
        registration_date,
        insurance_provider,
        insurance_number,
        email

    from source

)

select * from renamed
