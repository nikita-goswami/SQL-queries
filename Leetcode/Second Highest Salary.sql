Write a SQL query to get the second highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the query should return 200 as the second highest salary. If there is no second highest salary, then the query should return null.

+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+



Solution

1. select max(salary) as SecondHighestSalary from 
employee e 
cross join 
(select max(salary) as max_sal
FROM Employee )x
on salary<max_sal 

2. did not pass one test case where only one employee details were given and numm should be returned
SELECT 
CASE WHEN a.cnt=1 then null else b.SecondHighestSalary END AS SecondHighestSalary
FROM
(SELECT count(*) as cnt
FROM
(SELECT Salary
FROM Employee
GROUP BY Salary)x)a
CROSS JOIN 
(SELECT Salary as SecondHighestSalary
FROM
(SELECT Salary,
DENSE_RANK() OVER (ORDER BY Salary desc)my_rank
FROM Employee)x
WHERE my_rank=2
GROUP BY Salary)b

3. select b.Salary as SecondHighestSalary
from 
(select 2 as rnk) a 
left join 
(SELECT Salary,
DENSE_RANK() OVER (ORDER BY Salary desc)my_rank
FROM Employee) b
on rnk=my_rank 
group by 1

