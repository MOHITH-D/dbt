{{
    config(
        schema= 'transform',
        tags = 'patients'
    )
}}

with base as (
    select
        ROW_NUMBER() OVER (ORDER BY patient_id, first_name) AS sug_key_patient,
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
        registration_date
    from {{ ref('stg_raw__patients') }}
)

select
    *
from base
