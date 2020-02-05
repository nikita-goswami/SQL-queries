################################################################################################################################
Find total sales, num of units, number of visits, avg unit retail price, unique customers per department
################################################################################################################################


select d.Dept_ID, sum(d.sales) as sum_sales, sum(d.units) as sum_units,num_visits, sum(d.sales)/sum(d.units) as avgUnitRetailPrice, unique_cust
from Department d
LEFT JOIN
(select Dept_ID,count(*) as unique_cust
from
(select Dept_ID, Cust_ID
from Department
group by Cust_ID, Dept_ID)x
group by Dept_ID)y
ON y.Dept_ID=d.Dept_ID 
LEFT JOIN 
(select Dept_ID, count(*) as num_visits
from
(select Dept_ID, Date, Cust_ID
from Department
group by Dept_ID, Date, Cust_ID)z
group by Dept_ID)a
ON a.Dept_ID=d.Dept_ID
Group By d.Dept_ID


Learning : When lot of things need to be computed, rather than trying to do everything in a single query with subqueries,
divide into multiple tables and employ joins.
