with source as (

    select *
    from {{ source('crm', 'orders') }}

),

renamed as (

    select
        order_id,
        opportunity_id,
        customer_id,
        sales_rep_id,
        order_date,
        order_amount,
        upper(order_status) as order_status,
        updated_at,
        ingested_at
    from source

)

select *
from renamed