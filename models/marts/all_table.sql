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
item as (
    select * from {{ ref('stg_jaffle_shop__raw_Items') }}
),
product as(
    select * from {{ ref('stg_jaffle_shop__raw_products') }}
),
store as(
    select * from {{ ref('stg_jaffle_shop__raw_stores') }}
),
supplies as(
    select * from {{ ref('stg_jaffle_shop__raw_suppliers') }}
),
alltable as(
    select c.customer_id,c.customer_name,o.ordered_at,o.order_total,i.id,p.name,st.name,su.name
    from customer c
    join orders o on o.customer_id=c.customer_id
    join item i on i.order_id=o.order_id
    join product p on i.sku=p.sku
    join store st on o.store_id=st.id
    join supplies su on su.sku=i.sku
    order by c.customer_name
)
select * from alltable