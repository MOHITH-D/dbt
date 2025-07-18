{{
    config(
        schema='transform',
        tags='appointments'
    )
}}

select
    coalesce(appointment_id,'unknown') as appointment_key,
    coalesce(patient_id,'unknown')as patient_key,
    coalesce(doctor_id,'unknown') as doctor_key,
    to_date(appointment_date) as appointment_date,
    coalesce(to_varchar(appointment_time),'unknown') as appointment_time,
    coalesce(reason_for_visit,'unknown') as reason_for_visit,
    coalesce(status,'unknown')status
from {{ ref('stg_raw__appointments') }}