{{ config(
    materialized='incremental',
    incremental_strategy='insert_overwrite',
    partition_by={
        "field": "order_date",
        "data_type": "date"
    }
) }}


select
    id as order_id,
    user_id as customer_id,
    order_date,
    status

from {{source('jaffle_shop','orders')}}

{% if is_incremental() %}
    WHERE order_date >= DATEADD(DAY, -7, DATE '2018-04-04')
{% endif %}