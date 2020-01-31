Data is given for year 2015 and 2016 for sales and customers shopping at a particular department. Perform sales year on year and customer year
on year analysis.

Input :
CustID DeptID Date Sales
100	2	2015-9-17	200
200	1	2016-10-17	100
300	2	2015-9-17	50
100	4	2016-10-17	400
300	2	2015-9-18	50
200	1	2015-9-17	20
100	5	2015-4-2	50
300	1	2015-4-2	30
200	2	2016-10-17	500


Step 1: Create Inter Table - containing data grouped by year and DeptID

create table inter_retail as 
select DeptID, year, count(custID) as CC, sum(SS) as SS
from
(select DeptID, substr(date,1,4) as year, custID, sum(sales) as SS
from Retail
group by DeptID, year, custID)x
group by DeptID,year

Step 2 : Create separate table for 2015 and for 2016 and join to get previous and current value for sales and customers

select DeptID,CAST ((onesixSS-onefiveSS) AS float)/onefiveSS as salesyoy, CAST ((onesixCC-onefiveCC) AS float)/onesixCC as custyoy 
from
(select a.DeptID, onefiveSS, onesixSS, onefiveCC, onesixCC
from
(select DeptID, year, SS as onefiveSS, CC as onefiveCC
from inter_retail
where year='2015')a
left join
(select DeptID, year, SS as onesixSS, CC as onesixCC
from inter_retail
where year='2016')b
on a.DeptID=b.DeptID)c

