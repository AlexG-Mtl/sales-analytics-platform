with sales_reps as (

    select *
    from {{ ref('stg_crm__sales_reps') }}

),

employees as (

    select *
    from {{ ref('stg_hr__employees') }}

),

departments as (

    select *
    from {{ ref('stg_hr__departments') }}

),

joined as (

    select
        sr.sales_rep_id,
        sr.employee_id,
        sr.crm_rep_name,
        sr.region,
        sr.active_flag,

        e.first_name,
        e.last_name,
        e.employee_email,
        e.job_title,
        e.salary,
        e.hire_date,
        e.employment_status,

        d.department_id,
        d.department_name,
        d.cost_center

    from sales_reps sr

    left join employees e
        on sr.employee_id = e.employee_id

    left join departments d
        on e.department_id = d.department_id

)

select *
from joined