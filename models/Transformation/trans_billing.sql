{{
    config(
        schema='transform',
        tags='billings'
    )
}}
select 
    coalesce(bill_id,'unknown') as bill_key,
    coalesce(patient_id,'unknown') as patient_key,
    coalesce(treatment_id,'unknown') as treatment_key,
    to_date(bill_date) as bill_date,
    coalesce(amount,'unknown') as amount,
    coalesce(payment_method,'unknown') as payment_method,
    coalesce(payment_status,'unknown') as payment_status
from {{ ref('stg_raw__billings') }}