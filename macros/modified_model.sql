{% macro get_recently_modified_models(control_table='CTRL_TAB') %}
    select *
    from DBT_HOSPITAL.CONTROL_TABLE.{{ control_table }}
    where created_at > (
        select max(date(created_at))
        from DBT_HOSPITAL.CONTROL_TABLE.{{ control_table }}
    )
{% endmacro %}