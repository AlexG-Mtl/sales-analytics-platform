with source as (

    select *
    from {{ source('hr', 'departments') }}

),

renamed as (

    select
        department_id,
        department_name,
        cost_center,
        updated_at
    from source

)

select *
from renamed