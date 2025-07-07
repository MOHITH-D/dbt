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
