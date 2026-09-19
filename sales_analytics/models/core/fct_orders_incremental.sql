{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='merge'
) }}

with source as (

    select *
    from {{ ref('stg_crm__orders') }}

    {% if is_incremental() %}

    where updated_at >= dateadd(
        day,
        -2,
        (select max(updated_at) from {{ this }})
    )

    {% endif %}

)

select
    order_id,
    opportunity_id,
    customer_id,
    sales_rep_id,
    order_date,
    order_amount,
    order_status,
    updated_at,
    ingested_at
from source