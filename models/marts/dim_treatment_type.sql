{{
    config(
        schema='marts',
        materialized='incremental',
        unique_key='treatment_id'
    )
}}

select 
    treatment_type,
    description,
    min(cost)||'-'||max(cost) as cost_range,
    updated_date as last_updated_date
from {{ ref('trans_treatment') }}
group by treatment_type,description,last_updated_date