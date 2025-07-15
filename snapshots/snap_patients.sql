{% snapshot snap_patients %}
{{
  config(
    schema='snapshot',
    unique_key='patient_id',
    strategy='check',
    check_cols=['contact_number', 'insurance_provider'],
  )
}}

SELECT
    patient_id,
    first_name,
    last_name,
    gender,
    date_of_birth,
    contact_number,
    address,
    insurance_provider,
    insurance_number,
    email,
    registration_date
FROM {{ ref('trans_patient') }}

{% endsnapshot %}
