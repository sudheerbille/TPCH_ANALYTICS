{{
    config(
        materialized         ="incremental",
        incremental_strategy ="merge",
        unique_key           =["order_id", "order_line_id"]
    )
}}

with
    fact_orders as (
        select *
        from {{ ref("stg_orders") }}

        {% if is_incremental() %}

            where order_date > (select max(order_date) from {{ this }})

        {% endif %}
    ),
    fact_lineitem as (select * from {{ ref("stg_lineitem") }})

select
    orders.order_id,
    lineitem.order_line_id,
    orders.customer_id,
    orders.order_status,
    orders.order_date,
    split_part(order_priority, '-', 1) as order_priority_id,
    to_number(ltrim(split_part(clerk, '#', 2), 0)) as clerk_id,
    orders.ship_priority

from fact_orders as orders

left join fact_lineitem as lineitem on orders.order_id = lineitem.order_id
