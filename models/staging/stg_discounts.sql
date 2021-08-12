with order_aggs as (
	select "ProductID", "Discount", sum("Quantity") as "Total Quantity"
	from order_details
	group by 1, 2
	order by 1, 2)

select * from order_aggs
