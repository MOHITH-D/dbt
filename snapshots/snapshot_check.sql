{% snapshot check_snapshot%}
{{
    config(
        target_schema = "snapshot",
        unique_key = "c_custkey",
        strategy = "check",
        check_cols = ["c_custkey","c_name","c_address","c_nationkey"]
    )
}}
select * from {{ source('dbt_ex', 'customer') }}
{% endsnapshot%}