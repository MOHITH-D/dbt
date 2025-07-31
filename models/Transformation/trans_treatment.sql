{{
    config(
        schema='transform',
        tags=['treatments']
    )
}}

with A as (
    select
        coalesce(treatment_id, 'unknown') as treatment_id,
        coalesce(appointment_id, 'unknown') as appointment_id,
        coalesce(treatment_type, 'unknown') as treatment_type,
        coalesce(description, 'unknown') as description,
        coalesce(cost, 0) as cost,
        to_date(treatment_date) as treatment_date,
        current_timestamp as updated_date,
        upper(left(treatment_type, 3) || substring(treatment_id, 2)) as sug_treatment_key,
        created_at
    from {{ ref('stg_raw__treatments') }}
),

B as (
    select
        treatment_type,
        description,
        concat(
            cast(min(cost) as string), '-', cast(max(cost) as string)
        ) as cost_range,
        max(treatment_date) as last_updated
    from A
    group by treatment_type, description
),

C as (
    select
        *,
        upper(left(treatment_type, 3)) as tre,
        row_number() over (partition by treatment_type order by description) as rn
    from B
),

Final as (
    select
        c.treatment_type,
        c.description,
        c.cost_range,
        c.tre,
        c.rn,
        a.treatment_id,
        a.created_at
    from C c
    join A a
      on a.treatment_type = c.treatment_type
     and a.description = c.description
)

select
    concat(tre, '-', lpad(cast(rn as string), 3, '0')) as SK_Treatment,
    treatment_id,
    treatment_type,
    description,
    cost_range,
    created_at
from Final
