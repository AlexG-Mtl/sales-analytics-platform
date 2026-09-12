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