with 

orders as (

    select * from {{ ref('stg_orders')}}

),

payments as (

    select * from {{ ref('payments_aggregated') }}

),

users as (

    select * from {{ ref('dim_users') }}

),

joined as (

    select  
        orders.order_id,
        orders.user_id,
        orders.created_at,
        orders.updated_at,
        orders.shipped_at,
        orders.currency,
        orders.order_status,
        orders.order_status_category,
        orders.shipping_method,
        orders.amount_total,
        
        payments.gross_tax_amount, 
        payments.gross_amount, 
        payments.gross_shipping_amount,
        payments.gross_total_amount,

        case
            when users.first_order_id = orders.order_id then 'new'
            else 'repeat'
        end as user_type,

        case    
            when orders.currency = 'USD' then orders.amount_total
            else payments.gross_total_amount
        end as total_amount

    from orders
    left join payments  
        on orders.order_id = payments.order_id
    left join users
        on orders.user_id = users.user_id

)

select * from joined