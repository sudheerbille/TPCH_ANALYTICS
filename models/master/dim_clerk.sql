select distinct clerk_id,
       clerk as clerk_name,
       CURRENT_TIMESTAMP as LOAD_TS
from {{ ref('stg_orders') }}
