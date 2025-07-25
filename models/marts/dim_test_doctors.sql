{{
    config(
        schema='marts',
        materialized='incremental',
        unique_key='doctor_id',
        tags = 'doctors'
    )
}}
 

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

{% if is_incremental() %}
    where created_at > (select max(created_at) from DBT_HOSPITAL.TEST_CNTRL_TABLE.MODEL_EXECUTION_LOG where model_name= '{{ this.name }}') 
{% endif %}
