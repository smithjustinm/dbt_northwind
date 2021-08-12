select "ProductID", "Discount", sum("Quantity") as "Total Quantity"
from order_details
group by 1, 2
order by 1, 2
