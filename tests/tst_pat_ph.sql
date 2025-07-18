select contact_number
from {{ ref('trans_patient') }}
where not regexp_like(contact_number, '^[0-9]{10}$')
