{{
    config(
        schema='marts',
        tags='appointments'
    )
}}
select 
    a.appointment_key,
    p.patient_id as patient_key,
    d.doctor_id as doctor_key,
    a.appointment_date,
    a.appointment_time,
    a.reason_for_visit,
    a.status
from {{ ref('trans_appointment') }} a 
LEFT JOIN {{ ref('trans_patient') }} p on a.patient_key=p.patient_id
LEFT JOIN {{ ref('trans_doctor') }} d on a.doctor_key=d.doctor_id