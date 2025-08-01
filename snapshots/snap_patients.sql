{% snapshot snap_patients %}
{{
  config(
    schema='snapshot',
    unique_key='patient_id',
    strategy='check',
    check_cols=['contact_number', 'insurance_provider'],
    tags = 'patients'
  )
}}

SELECT
    *
FROM {{ ref('trans_patient') }}

{% endsnapshot %}
