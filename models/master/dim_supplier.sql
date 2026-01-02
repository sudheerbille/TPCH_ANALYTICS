select s.supplier_id,
       s.supplier_name,
       s.phone,
       s.account_balance,
       c.country_name,
       c.region_name
from {{ ref('stg_supplier') }} as s

left join {{ ref('dim_country') }} as c
on s.country_code = c.country_code