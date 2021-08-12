-- example query for sum discount with 'case when'
select sum(case 
            when "Discount" = 0 then 1 
            else 0
        end
    ) as "No Discount",
    sum(case
        when "Discount" > 0 then 1
        else 0
        end
    ) as "Discount"
from public.order_details