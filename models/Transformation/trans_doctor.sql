{{
    config(
        schema= 'transform'
    )
}}
select
    coalesce(doctor_id,'unknown' )as doctor_key,
    coalesce(first_name,'unknown') as first_name,
    coalesce(last_name,'unknown') as last_name,
    coalesce(specialization,'unknown') as specialization,
    coalesce(phone_number,'unknown') as phone_number,
    coalesce(years_experience,'unknown') as years_experience,
    coalesce(hospital_branch,'unknown') as hospital_branch,
    coalesce(email,'unknown') as email
from {{ ref('stg_raw__doctors') }}