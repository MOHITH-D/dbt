{{
    config(
        schema='marts'
    )
}}

select
  {{ dbt_utils.star(ref('trans_billing')) }}
from {{ ref('trans_billing') }}
