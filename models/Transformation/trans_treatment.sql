{{
    config(
        schema='transform'
    )
}}
select
    coalesce(treatment_id,'unknown') as treatment_id,
    coalesce(appointment_id,'unknown') as appointment_id,
    coalesce(treatment_type,'unknown') as treatment_type,
    coalesce(description,'unknown') as description,
    coalesce(cost,'unknown') as cost,
    to_date(treatment_date) as treatment_date,
    current_timestamp as updated_date,
    UPPER(LEFT(treatment_type,3)||SUBSTRING(treatment_id,2)) as sug_treatment_key
from {{ ref('stg_raw__treatments') }}