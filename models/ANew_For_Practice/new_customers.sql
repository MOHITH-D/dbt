with new_customers as(
    select * from {{ ref('stg_new_customers') }}
)
select * from new_customers