select
    order_id,
    sum(amount) as Total
from
    {{ ref('stg_stripe__payments') }}
group by 1
having total<0
