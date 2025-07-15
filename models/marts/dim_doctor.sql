{{
    config(
        schema='marts',
        materialized='incremental',
        unique_key='doctor_id'
    )
}}

select 
    doctor_id,
    first_name,
    last_name,
    specialization,
    phone_number,
    years_experience,
    hospital_branch,
    email,
    updated_date as last_updated_date
 from {{ ref('trans_doctor') }}