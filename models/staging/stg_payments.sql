with

source as (

    select * from {{ source('interview_task', 'payments')}}

),

renamed as (

    select
        --ids
        payment_id,
        order_id,

        --dimensions
        status,
        payment_type,
        tax_amount_cents / 100 as tax_amount,
        amount_cents / 100 as amount,
        amount_shipping_cents / 100 as amount_shipping

    from source

)

select * from renamed