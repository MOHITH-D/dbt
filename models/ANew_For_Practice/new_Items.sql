with new_items as(
    select * from {{ ref('stg_new_items') }}
)
select * from new_items