{{
    config(
        schema='marts',
        materialized='incremental',
        unique_key='patient_id',
        tags = 'patients'
    )
}}

with pat as(
    select 
        sug_key_patient,
        patient_id,
        first_name,
        last_name,
        gender,
        date_of_birth,
        contact_number,
        address,
        insurance_provider,
        insurance_number,
        email,
        registration_date,
        current_date as effective_start_date,
        NULL as effective_end_date,
        case 
            when effective_end_date is null then 'Y'
            else 'N'
        end as is_current
        from {{ ref('snap_patients')}}
)
select * from pat


