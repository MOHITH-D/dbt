{{
    config(
        schema= 'transform',
        tags = 'doctors'
    )
}}

select
    coalesce(doctor_id, 'unknown') as doctor_id,
    coalesce(first_name, 'unknown') as first_name,
    coalesce(last_name, 'unknown') as last_name,
    coalesce(specialization, 'unknown') as specialization,
    case 
        when regexp_like(to_varchar(cast(phone_number as int)), '^[0-9]{10}$') 
            then to_varchar(cast(phone_number as int))
            else 'invalid_phone'
    end as phone_number,
    coalesce(years_experience, 'unknown') as years_experience,
    coalesce(hospital_branch, 'unknown') as hospital_branch,
    case 
        when email ilike concat('dr.', lower(first_name), '.', lower(last_name), '@hospital.com') then email
        else 'invalid_email'
    end as email,
    created_at
from {{ ref('stg_raw__doctors') }}
