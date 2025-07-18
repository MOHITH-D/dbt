{{
    config(
        schema='marts',
        materialized='incremental',
        unique_key='treatment_id',
        tags='treatments'
    )
}}

with treatment as (
  select
    treatment_type,
    description,
    concat(
        cast(min(cost) as string), '-',
        cast(max(cost) as string)
    ) as cost_range,
    max(treatment_date) as last_updated
 from {{ ref('trans_treatment') }}
 group by treatment_type, description
),
 
t1 as (
    select *,
    upper (left(treatment_type,3)) as tre,
    row_number() over (partition by treatment_type order by description) as rn
    from treatment
)
 
select
    concat(tre,'-',lpad(cast(rn as string),3,'0')) as treatment_id,
    treatment_type,
    description,
    cost_range,
    last_updated
from t1