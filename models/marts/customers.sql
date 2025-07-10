{{
    config(
        materialized='table'
    )
}}

with customer as(
    select * from {{ ref('stg_jaffle_shop__raw_customers') }}
),
orders as (
    select * from {{ ref('stg_jaffle_shop__raw_orders') }}
),
detail as (
    select c.customer_id,c.customer_name,sum(o.order_total) as total_amt 
    from customer c 
    join orders o on c.customer_id=o.customer_id
    group by c.customer_id,c.customer_name
    order by c.customer_name
)
select * from detail