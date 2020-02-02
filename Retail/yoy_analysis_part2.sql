# Calculate products which were not sold in 2014 and sold in 2015 and later had more than 100% sales increase in 2016

Input :
custID ItemID date Amount
100	1	2014-10-07	100
200	2	2015-12-25	200
300	2	2015-10-07	200
400	4	2016-10-07	300
300	2	2016-10-07	400
400	2	2016-10-07	400
500	2	2016-10-07	400
600	2	2016-10-07	400
100	2	2016-10-07	400



Create Purchase Table Table

create table Purchase as
select ItemID, substr(Date,1,4) as year, (count(*)*sum(Amount)) as sale
from sales_table
group by ItemID, year

Purchase
itemID year sale
1	2014	100
2	2015	800
2	2016	10000
4	2016	300

select interim.bitemID, interim.bsales, interim.csales, (interim.csales - interim.bsales)/interim.bsales as yoy_sales
from (select bsales.ItemID as bitemID, bsales.sale as bsales, csales.ItemID as citemID, csales.sale as csales
from (
select ItemID, sale
from Purchase
where year = '2016')csales
INNER JOIN
(select b.ItemID, b.sale
from (select ItemID, sale from Purchase
where year = '2015')b
where b.ItemID NOT IN
(select ItemID
from Purchase where year = '2014'))bsales
ON csales.ItemID = bsales.ItemID
WHERE csales.sale >= (2 * bsales.sale))interim


			
