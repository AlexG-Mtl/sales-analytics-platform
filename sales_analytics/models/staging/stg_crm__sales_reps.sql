with source as (

    select *
    from {{ source('crm', 'sales_reps') }}

),

renamed as (

    select
        sales_rep_id,
        employee_id,
        crm_rep_name,
        region,
        active_flag,
        updated_at
    from source

)

select *
from renamed