select distinct split_part(order_priority,'-',1) as order_priority_id,
       split_part(order_priority,'-',2) as order_priority
from {{ ref('stg_orders') }}