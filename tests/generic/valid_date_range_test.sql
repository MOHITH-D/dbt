
{% test valid_date(model, column_name) %}
    with invalid_dates as (
        select *
        from {{ ref(model) }}
        where {{ column_name }} > current_date
    )

    select *
    from invalid_dates
{% endtest %}
