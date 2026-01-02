select order_priority_id, count(*) 
from {{ ref('stg_order_priority') }}
group by order_priority_id
having count(*)>1