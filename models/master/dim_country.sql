select c.country_code, c.country_name, r.region_name, CURRENT_TIMESTAMP() AS LOAD_TS

from {{ ref("stg_country") }} as c

left join {{ ref("stg_region") }} as r on c.region_code = r.region_code
