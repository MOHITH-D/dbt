with 

source as (

    select * from {{ source('control', 'model_execution_log') }}

),

renamed as (

    select
        id,
        model_name,
        status,
        started_at,
        ended_at,
        run_duration,
        created_at

    from source

)

select * from renamed
