{{
    config(
        materialized= 'incremental',
        unique_key= 'c_custkey',
        pre_hook= "
            truncate table {{this}};
            insert into EX.DBT_MD.AUDIT_LOG (model,event,time) values
            ('{{this}}','start customer table',current_timestamp);
        ",
        post_hook= "
            insert into EX.DBT_MD.AUDIT_LOG (model,event,time) values
            ('{{this}}','end customer table',current_timestamp);
        "
    )
}}

with 
source as (
    select * from {{ source('dbt_ex', 'customer') }}
),

customers as (

    select
        c_custkey,
        c_name,
        c_address,
        c_nationkey,
        c_phone,
        c_acctbal,
        c_mktsegment,
        c_comment

    from source

)

select * from customers
