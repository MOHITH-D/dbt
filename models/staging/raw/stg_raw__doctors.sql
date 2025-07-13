with 

source as (

    select * from {{ source('raw', 'doctors') }}

),

renamed as (

    select
        doctor_id,
        first_name,
        last_name,
        specialization,
        phone_number,
        years_experience,
        hospital_branch,
        email

    from source

)

select * from renamed
