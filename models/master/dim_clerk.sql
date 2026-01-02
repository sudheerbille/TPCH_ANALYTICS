select distinct to_number(ltrim(split_part(clerk, '#', 2), 0)) as clerk_id,
       clerk
from {{ ref('stg_orders') }}
