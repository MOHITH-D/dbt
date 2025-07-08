select 
    o_orderkey,
    o_custkey,
    o_orderstatus,
    o_totalprice,
    {{discount('o_totalprice')}} as discount_price
from {{ source('dbt_ex', 'orders') }}