with new_customers as(
    select * from {{ ref('stg_new_customers') }}
),
new_orders (
    select * from {{ ref('stg_new_orders') }}
)

select * from new_customers