with prod_name as (
	select "ProductID", "ProductName"
	from public.products
	)

select * from prod_name