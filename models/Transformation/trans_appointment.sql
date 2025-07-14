{{
    config(
        schema='transform'
    )
}}


select 
    appointment_id as appointment_key,
    patient_id as patient_key,
    doctor_id as doctor_key,
    appointment_date,
    appointment_time,
    reason_for_visit,
    status
from {{ ref('stg_raw__appointments') }}