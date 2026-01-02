select distinct r_regionkey as region_code,
       r_name               as region_name
from {{ source('tpch_sf1', 'region') }}
order by 1

