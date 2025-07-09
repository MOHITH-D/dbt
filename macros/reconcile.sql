{% test reconcile_row_count_macro(model, source_model, target_model, source_key, target_key) %}
    with
        source_count as (
            select count(distinct {{ source_key }}) as row_count
            from {{ ref(source_model) }}
        ),
        target_count as (
            select count(distinct {{ target_key }}) as row_count
            from {{ ref(target_model) }}
        )
    select *
    from source_count
    join target_count on 1=1
    where source_count.row_count != target_count.row_count
{% endtest %}
