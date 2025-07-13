with 

source as (

    select * from {{ source('raw', 'billings') }}

),

renamed as (

    select
        bill_id,
        patient_id,
        treatment_id,
        bill_date,
        amount,
        payment_method,
        payment_status

    from source

)

select * from renamed
