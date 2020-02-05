####################################################################################################################################
Find out new customers i.e. Find customers who have purchased in 2019 but not in 2018 (Do not use NOT IN)
####################################################################################################################################

select x.new_cust from
(select n.Cust_ID as new_cust, p.Cust_ID as old_cust
from Sales_new n 
LEFT JOIN Sales_Prev p
ON n.Cust_ID=p.Cust_ID) x
where x.old_cust IS NULL
