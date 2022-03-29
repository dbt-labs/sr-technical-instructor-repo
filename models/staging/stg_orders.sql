with

source as (

    select * from {{ source('interview_task', 'orders')}}

),

renamed as (

    select
        --ids
        order_id,
        user_id,

        --dimensions
        currency,
        status as order_status,
        case
            when status in ('paid', 'completed', 'shipped') then 'completed'
            else status
        end as order_status_category,
        shipping_method,
        amount_total_cents / 100 as amount_total,

        --dates
        created_at,
        shipped_at,
        updated_at

    from source

)

select * from renamed