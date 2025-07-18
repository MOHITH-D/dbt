select phone_number,email
from {{ ref('trans_doctor') }}
where not regexp_like(phone_number, '^[0-9]{10}$')
   or not regexp_like(email, '^dr\.[a-z]+\.[a-z]+@hospital\.com$')
