{{
    config(
        materialized="incremental",
        incremental_strategy="merge",
        unique_key=["order_id", "order_line_id"]
    )
}}

with
    orders as (
        select *
        from {{ ref("stg_orders") }}

        {% if is_incremental() %}

            where order_id > (select max(order_id) from {{ this }})

        {% endif %}
    ),
    lineitem as (select * from {{ ref("stg_lineitem") }})

select
    orders.order_id,
    lineitem.order_line_id,
    orders.customer_id,
    orders.order_status,
    orders.order_date,
    orders.order_priority_id,
    orders.clerk_id,
    orders.ship_priority,
    lineitem.part_id,
    lineitem.supplier_id,
    lineitem.quantity,
    lineitem.extended_price,
    lineitem.discount,
    lineitem.tax,
    lineitem.return_flag,
    lineitem.line_status,
    lineitem.ship_date,
    lineitem.commit_date,
    lineitem.receipt_date,
    round(datediff('day',orders.order_date,lineitem.receipt_date),0) as days_to_deliver,
    iff(receipt_date <= commit_date,'yes','no') as on_time_flag,
    lineitem.ship_instructions,
    lineitem.ship_mode,
    CURRENT_TIMESTAMP as LOAD_TS,
    CURRENT_TIMESTAMP as UPDATE_TS

from orders

left join lineitem on orders.order_id = lineitem.order_id
