select customer_id,
case when Department=1 then 1 else 0 end as d1,
case when Department=2 then 1 else 0 end as d2,
case when Department=5 then 1 else 0 end as d5,
case when Department=7 then 1 else 0 end as d7
from Trans




SELECT customer_id,max(d1),max(d2),max(d5),max(d7) 
FROM
(select customer_id,
case when Department=1 then 1 else 0 end as d1,
case when Department=2 then 1 else 0 end as d2,
case when Department=5 then 1 else 0 end as d5,
case when Department=7 then 1 else 0 end as d7
from Trans) x
GROUP BY customer_id
