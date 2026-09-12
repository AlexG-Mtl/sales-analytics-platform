with sales_reps as (

    select *
    from {{ ref('int_sales_rep_enriched') }}

),

opportunities as (

    select *
    from {{ ref('stg_crm__opportunities') }}

),

orders as (

    select *
    from {{ ref('stg_crm__orders') }}

),

opportunity_metrics as (

    select
        sales_rep_id,
        count(*) as opportunity_count,
        count_if(opportunity_stage = 'CLOSED_WON') as won_opportunity_count,
        count_if(opportunity_stage = 'CLOSED_LOST') as lost_opportunity_count,
        sum(opportunity_amount) as total_pipeline_amount,
        sum(
            case
                when opportunity_stage = 'CLOSED_WON'
                then opportunity_amount
                else 0
            end
        ) as closed_won_amount
    from opportunities
    group by sales_rep_id

),

order_metrics as (

    select
        sales_rep_id,
        count(*) as order_count,
        sum(order_amount) as total_order_revenue
    from orders
    where order_status = 'COMPLETED'
    group by sales_rep_id

)

select
    sr.sales_rep_id,
    sr.employee_id,
    sr.crm_rep_name,
    sr.region,
    sr.job_title,
    sr.department_name,
    sr.employment_status,

    coalesce(om.opportunity_count, 0) as opportunity_count,
    coalesce(om.won_opportunity_count, 0) as won_opportunity_count,
    coalesce(om.lost_opportunity_count, 0) as lost_opportunity_count,
    coalesce(om.total_pipeline_amount, 0) as total_pipeline_amount,
    coalesce(om.closed_won_amount, 0) as closed_won_amount,

    coalesce(ord.order_count, 0) as order_count,
    coalesce(ord.total_order_revenue, 0) as total_order_revenue,

    case
        when coalesce(om.opportunity_count, 0) = 0 then 0
        else om.won_opportunity_count / om.opportunity_count::float
    end as win_rate

from sales_reps sr

left join opportunity_metrics om
    on sr.sales_rep_id = om.sales_rep_id

left join order_metrics ord
    on sr.sales_rep_id = ord.sales_rep_id