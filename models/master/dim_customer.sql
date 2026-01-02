select customer.customer_id,
       customer.customer_name,
       customer.account_balance,
       country.country_name,
       country.region_name

from {{ ref('stg_customer') }} as customer

left join {{ ref('dim_country') }} as country 
on customer.country_code = country.country_code