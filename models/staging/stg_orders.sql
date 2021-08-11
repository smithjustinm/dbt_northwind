with orders as (
	select
		"OrderID",
		"CustomerID",
		"OrderDate"
	from public.orders
)

select * from orders

