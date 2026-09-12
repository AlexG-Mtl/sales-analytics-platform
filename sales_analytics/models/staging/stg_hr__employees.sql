with source as (

    select *
    from {{ source('hr', 'employees') }}

),

renamed as (

    select
        employee_id,
        first_name,
        last_name,
        lower(email) as employee_email,
        department_id,
        manager_id,
        job_title,
        salary,
        hire_date,
        upper(employment_status) as employment_status,
        updated_at
    from source

)

select *
from renamed