with

payments as (

    select * from {{ ref('stg_payments')}}

),

aggregated as (

    select
        order_id, 
        sum(case when status = 'completed' then tax_amount else 0 end) as gross_tax_amount, 
        sum(case when status = 'completed' then amount else 0 end) as gross_amount, 
        sum(case when status = 'completed' then amount_shipping else 0 end) as gross_shipping_amount,
        sum(case when status = 'completed' then tax_amount + amount + amount_shipping else 0 end) as gross_total_amount
    from payments
    group by 1

)

select * from aggregated