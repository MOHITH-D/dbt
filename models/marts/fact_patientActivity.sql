{{
    config(
        schema='marts'
    )
}}

WITH appointments AS (
    SELECT
        patient_key,
        COUNT(*) AS total_appointments,
        COUNT(CASE WHEN status = 'No-show' THEN 1 END) AS no_show_count,
        MIN(appointment_date) AS first_appointment_date,
        MAX(appointment_date) AS last_appointment_date
    FROM {{ ref('fact_appointment') }}
    GROUP BY patient_key
    order by patient_key asc
),

billing AS (
    SELECT
        patient_key,
        SUM(amount) AS total_billed,
        SUM(CASE WHEN payment_status = 'Paid' THEN amount ELSE 0 END) AS total_paid
    FROM {{ ref('fact_billing') }}
    GROUP BY patient_key
)

SELECT
    COALESCE(a.patient_key, b.patient_key) AS patient_key,
    COALESCE(total_appointments, 0) AS total_appointments,
    COALESCE(total_billed, 0) AS total_billed,
    COALESCE(total_paid, 0) AS total_paid,
    COALESCE(no_show_count, 0) AS no_show_count,
    a.first_appointment_date,
    a.last_appointment_date
FROM appointments a
FULL OUTER JOIN billing b
  ON a.patient_key = b.patient_key
