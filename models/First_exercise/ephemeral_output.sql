select * 
from {{ ref('ephemeral') }}
where C_PHONE is not null