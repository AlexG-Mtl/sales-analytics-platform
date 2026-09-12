with source as (

    select *
    from {{ source('crm', 'opportunities') }}

),

renamed as (

    select
        opportunity_id,
        customer_id,
        sales_rep_id,
        upper(stage) as opportunity_stage,
        opportunity_amount,
        created_at,
        close_date,
        updated_at
    from source

)

select *
from renamed