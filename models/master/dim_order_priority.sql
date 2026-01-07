select distinct order_priority_id,
       order_priority_desc as order_priority,
       CURRENT_TIMESTAMP as LOAD_TS
from {{ ref('stg_orders') }} 