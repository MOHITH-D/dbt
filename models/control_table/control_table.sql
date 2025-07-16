{{ config(materialized='table', schema='dbt_metadata') }}

select 
    '' as run_id,
    '' as model_name,
    '' as status,
    current_timestamp() as start_time,
    current_timestamp() as end_time,
    0 as duration_seconds,
    0 as row_count,
    '{{ target.name }}' as environment,
    '' as error_message
where 1 = 0