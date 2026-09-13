{{ config(
    post_hook="
        ALTER VIEW {{ this }}
        MODIFY COLUMN CUSTOMER_EMAIL
        SET MASKING POLICY SALES_ANALYTICS.GOVERNANCE.EMAIL_MASK
    "
) }}

with source as (

    select *
    from {{ source('crm', 'customers') }}

),

renamed as (

    select
        customer_id,
        customer_name,
        lower(email) as customer_email,
        region,
        created_at,
        updated_at
    from source

)

select *
from renamed
