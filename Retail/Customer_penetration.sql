Given a table with following Data - DeptID, Date, CustID, Sales (working query)
DB : sales
Output : Dept No, Customer Penetration (unique customer visiting a department/ total no of unique customers), Total Sales for a department

Look out for : Use of Inner Join with join condition 1:1 (made it act like a cross join)

select DeptID, CAST (CC AS float)/Tot as cust_penetration, SS
from
(select DeptID, count(*) as CC, sum(SS) as SS
from
(select DeptID, custID, sum(sales) as SS
from sales
Group by DeptID, custID)x
Group by DeptID)Dept_Stats
inner join
(select count(*) as Tot
from
(select custID
from sales
group by custID)x)overall
on 1=1


Finding sale share per department

select DeptID, CAST (CC AS float)/Tot as cust_penetration, CAST (SS AS float)/TS as sales_share
from
(select DeptID, count(*) as CC, sum(SS) as SS
from
(select DeptID, custID, sum(sales) as SS
from sales
Group by DeptID, custID)x
Group by DeptID)Dept_Stats
inner join
(select count(*) as Tot, sum(Tot_sales) as TS
from
(select custID, sum(sales) as Tot_sales
from sales
group by custID)x)overall
on 1=1
