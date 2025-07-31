{{
    config(
        schema='marts',
        materialized='incremental',
        unique_key='doctor_id',
        tags = 'doctors'
    )
}}
 
with source as (
    select
        doctor_id,
        first_name,
        last_name,
        specialization,
        phone_number,
        years_experience,
        hospital_branch,
        email,
        created_at
    from {{ ref('trans_doctor') }}
),
 
{% if is_incremental() %}
 
target as (
    select * from {{ this }}
)
 
, final as (
    select
        src.doctor_id,
        src.first_name,
        src.last_name,
        src.specialization,
        src.phone_number,
        src.years_experience,
        src.hospital_branch,
        src.email,
        coalesce(tgt.created_at, src.created_at) as created_at,

        case
            when tgt.doctor_id is not null and (
                src.first_name <> tgt.first_name or
                src.last_name <> tgt.last_name or
                src.specialization <> tgt.specialization or
                src.phone_number <> tgt.phone_number or
                src.years_experience <> tgt.years_experience or
                src.hospital_branch <> tgt.hospital_branch or
                src.email <> tgt.email
            )
            then current_timestamp()
            else tgt.updated_at
        end as updated_at
 
    from
        source src
    left join target tgt
        on src.doctor_id = tgt.doctor_id
)
 
select * from final
 
{% else %}
 
select
    *,
    null as updated_at
from source
 
{% endif %}
 