{% test valid_date(model, column_name) %}
    with
        invalid_dates as (
            select *
            from {{ ref(model) }}
            where
                {{ column_name }} < '2025-07-06' or {{ column_name }}  > current_date
        )
    select count(*) as invalid_date_count
    from invalid_dates
    having count(*) > 0;
{% endtest %}
