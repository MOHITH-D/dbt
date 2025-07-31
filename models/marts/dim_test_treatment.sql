{{
    config(
        schema='marts',
        materialized='incremental',
        unique_key='treatment_id',
        tags='treatments'
    )
}}
 

select
    treatment_id,
    treatment_type,
    description,
    cost_range,
    created_at
from {{ ref('trans_treatment') }}

{% if is_incremental() %}
    where created_at > (select max(created_at) from DBT_HOSPITAL.TEST_CNTRL_TABLE.MODEL_EXECUTION_LOG where model_name= '{{ this.name }}') 
{% endif %}
