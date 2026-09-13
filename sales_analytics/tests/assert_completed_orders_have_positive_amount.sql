select
    order_id,
    order_amount,
    order_status
from {{ ref('stg_crm__orders') }}
where order_status = 'COMPLETED'
  and order_amount <= 0