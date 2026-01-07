select
    o_orderkey      as order_id,
    o_custkey       as customer_id,
    o_orderstatus   as order_status,
    o_orderdate     as order_date,
    o_orderpriority as order_priority,
    split_part(order_priority,'-',1) as order_priority_id,
    split_part(order_priority,'-',2) as order_priority_desc,
    o_clerk         as clerk,
    to_number(ltrim(split_part(clerk, '#', 2), 0)) as clerk_id,
    o_shippriority  as ship_priority

from {{ source('tpch_sf1', 'orders') }}
