{{
    config(
        schema= 'transform',
        tags = 'patients'
    )
}}

with base as (
    select
        concat(
            coalesce(cast(patient_id as string), 'NULL'),
            coalesce(cast(contact_number as string), 'NULL'),
            coalesce(cast(insurance_number as string), 'NULL')
        ) as sug_key_patient,

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
