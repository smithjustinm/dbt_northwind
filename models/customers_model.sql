
with customers as (

    select * 
    
    from {{ ref('stg_customers')}}
    
),

orders as (

    select *

    from {{ ref('stg_orders')}}

),

customer_orders as (

    select
        "CustomerID",
        min("OrderDate") as first_order_date,
        max("OrderDate") as most_recent_order_date,
        count("OrderID") as number_of_orders

    from orders

    group by 1

),


final as (

    select
        customers_model."CustomerID",
        customers_model."CompanyName",
        customers_model."City",
        customers_model."Country",
        orders."ShipVia",
        orders."Freight",
        customer_orders."first_order_date",
        customer_orders."most_recent_order_date",
        coalesce(customer_orders."number_of_orders", 0) as number_of_orders

    from customers_model, customer_orders

    left join orders using ("CustomerID")

)

select * from final