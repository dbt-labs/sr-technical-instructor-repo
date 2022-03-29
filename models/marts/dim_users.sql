with 

orders as (

    select * from {{ ref('stg_orders') }}
    where order_status != 'cancelled'

),

flatten as (

    select
        user_id,
        min(created_at) as first_order_date,
        min(order_id) as first_order_id
    from orders
    group by 1

)

select * from flatten