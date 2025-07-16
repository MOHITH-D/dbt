{% snapshot snap_patients %}
{{
  config(
    schema='snapshot',
    unique_key='sug_key_patient',
    strategy='check',
    check_cols=['contact_number', 'insurance_provider'],
  )
}}

SELECT
    *
FROM {{ ref('trans_patient') }}

{% endsnapshot %}
