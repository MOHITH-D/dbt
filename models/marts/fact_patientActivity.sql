{{
    config(
        schema='marts'
    )
}}

with appointments as (
    select
        patient_key,
        count(*) as total_appointments,
        count(case when status='No-show' then 1 end) as no_show_count,
        min(appointment_date) as first_appointment_date,
        max(appointment_date) as last_appointment_date
    from {{ ref('fact_appointment') }}
    group by patient_key
    order by patient_key asc
),

billing as (
    select
        patient_key,
        sum(amount) as total_billed,
        sum(case when payment_status='Paid' then amount else 0 end) as total_paid
    from {{ ref('fact_billing') }}
    group by patient_key
)

select
    coalesce(a.patient_key, b.patient_key) as patient_key,
    coalesce(total_appointments, 0) as total_appointments,
    coalesce(total_billed, 0) as total_billed,
    coalesce(total_paid, 0) as total_paid,
    coalesce(no_show_count, 0) as no_show_count,
    a.first_appointment_date,
    a.last_appointment_date
from appointments a
FULL OUTER JOIN billing b
  ON a.patient_key = b.patient_key
