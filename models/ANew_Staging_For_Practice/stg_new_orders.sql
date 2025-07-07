select
    id as order_id,
    customer as customer_id,
    order_at,
    store_id,
    sub_total,
    tax_paid,
    order_total
from {{ source('new_shop', 'new_orders') }}