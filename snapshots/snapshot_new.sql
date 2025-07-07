{% snapshot customer_snapshot %}
{{config(
    target_schema = "snapshot",
    unique_key = "c_custkey",
    strategy = "timestamp",
    updated_at = "last_updated"
)}}
select
        c_custkey,
        c_name,
        c_address,
        c_nationkey,
        c_phone,
        c_acctbal,
        c_mktsegment,
        c_comment,
        last_updated
    from {{ source('updated_timestamp', 'dbt_ex_customer') }}
{% endsnapshot%}

