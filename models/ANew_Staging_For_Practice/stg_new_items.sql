select 
    id as customer_id,
    order_id,
    sku
from {{ source('new_shop', 'raw_items') }}