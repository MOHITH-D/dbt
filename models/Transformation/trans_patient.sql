{{
    config(
        schema= 'transform'
    )
}}
select
        coalesce(patient_id,'unknown') as patient_id,
        coalesce(first_name,'unknown') as first_name,
        coalesce(last_name,'unknown') as last_name,
        coalesce(gender,'unknown') as gender,
        to_date(date_of_birth) as date_of_birth,
        coalesce(contact_number,'unknown') as contact_number,
        coalesce(address,'unknown')address,
        to_date(registration_date) as registration_date,
        coalesce(insurance_provider,'unknown') as insurance_provider,
        coalesce(insurance_number,'unknown') as insurance_number,
        coalesce(email,'unknown') as email
from {{ ref('stg_raw__patients') }} 




    
