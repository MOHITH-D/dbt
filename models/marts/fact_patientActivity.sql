{{
    config(
        schema='marts'
    )
}}

with appointments as (
    select
        patient_key,
        COUNT(*) as total_appointments,
        COUNT(case when status = 'No-show' then 1 end) as no_show_count,
        MIN(appointment_date) as first_appointment_date,
        MAX(appointment_date) as last_appointment_date
    from {{ ref('fact_appointment') }}
    group by patient_key
    order by patient_key asc
),

billing as (
    select
        patient_key,
        SUM(amount) as total_billed,
        SUM(case when payment_status = 'Paid' then amount else 0 end) as total_paid
    from {{ ref('fact_billing') }}
    group by patient_key
)

select
    COALESCE(a.patient_key, b.patient_key) as patient_key,
    COALESCE(total_appointments, 0) as total_appointments,
    COALESCE(total_billed, 0) as total_billed,
    COALESCE(total_paid, 0) as total_paid,
    COALESCE(no_show_count, 0) as no_show_count,
    a.first_appointment_date,
    a.last_appointment_date
from appointments a
FULL OUTER JOIN billing b
  ON a.patient_key = b.patient_key
