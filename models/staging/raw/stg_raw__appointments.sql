{{
    config(
        schema='staging'
    )
}}


with 

source as (

    select * from {{ source('raw', 'appointments') }}

),

renamed as (

    select
        appointment_id,
        patient_id,
        doctor_id,
        appointment_date,
        appointment_time,
        reason_for_visit,
        status

    from source

)

select * from renamed
