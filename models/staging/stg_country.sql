select distinct n_nationkey as country_code, 
       n_name               as country_name, 
       n_regionkey          as region_code
from {{ source('tpch_sf1', 'nation') }}
