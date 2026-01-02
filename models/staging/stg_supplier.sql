select
    s_suppkey as supplier_id,
    s_name as supplier_name,
    s_nationkey as country_code,
    s_phone as phone,
    s_acctbal as account_balance

from {{ source("tpch_sf1", "supplier") }}
