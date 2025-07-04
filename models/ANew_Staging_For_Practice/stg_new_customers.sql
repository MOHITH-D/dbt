select
    id as customer_id,
    name as Customer_name
from {{ source('new_shop','raw_customers') }}