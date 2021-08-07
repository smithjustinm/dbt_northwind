
with customers_model as (

    select 
        "CustomerID",
        "CompanyName",
        "City",
        "Country"

    from customers

),

orders as (

    select
        "OrderID",
        "CustomerID",
        "OrderDate",
        "ShipVia",
        "Freight"

    from orders

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
        customer_orders."first_order_date",
        customer_orders."most_recent_order_date",
        coalesce(customer_orders."number_of_orders", 0) as number_of_orders

    from customers_model, customer_orders

    left join orders using ("CustomerID")

)

select * from final