/* Q1) There are two tables (tab1 and tab2). Both have one column and below is the data.

Tab1 (col1)
1
1
NULL

Tab2 (col1)
1
1
NULL
NULL

How many records would every join (LOJ, ROJ and FOJ) result?
*/

DECLARE @tab1 TABLE (id INT)
INSERT INTO @tab1 (id)
VALUES 
	 (1)
	,(1)
	,(NULL)


DECLARE @tab2 TABLE (id INT)
INSERT INTO @tab2 (id)
VALUES 
	 (1)
	,(1)
	,(NULL)
	,(NULL)



------Inner Join 4 records
SELECT 
	 a.*
	,b.*
FROM @tab1 a
	JOIN @tab2 b 	
		ON a.id = b.id


------Left Outer Join 5 records
SELECT 
	 a.*
	,b.*
FROM @tab1 a
	LEFT OUTER JOIN @tab2 b 
		ON a.id = b.id


------Right Outer 6 records
SELECT 
	 a.*
	,b.*
FROM @tab1 a
	RIGHT OUTER JOIN @tab2 b 
		ON a.id = b.id


------Full outer 7 records
SELECT 
	 a.*
	,b.*
FROM @tab1 a
	FULL OUTER JOIN @tab2 b 
		ON a.id = b.id





/*
Q2) How can we Transpose a table using SQL( changing rows to column or Vice-Versa)?

For Instance how can we return from a table like the one below

employee_id salary_component_id salary_component_desc Value month
1 1 salary 2000 "2015-09"
1 2 bonus 100 "2015-09"
1 3 indennity 250 "2015-09"
1 1 salary 2000 "2015-10"
1 2 bonus 0 "2015-10"
1 3 indennity 150 "2015-10"
2 1 salary 1500 "2015-09"
2 2 bonus 0 "2015-09"
2 3 indennity 50 "2015-09"

following results?
employee_id month salary bonus indennity
1 "2015-09" 2000 100 250
1 "2015-10" 2000 0 150
2 "2015-09" 1500 0 50
*/


DECLARE @t TABLE (
	employee_id INT
	,salary_component_id INT
	,salary_component_desc NVARCHAR(50)
	,Value INT
	,month_id NVARCHAR(50)
	)

insert into @t (employee_id,salary_component_id,salary_component_desc,value,month_id)values

('1','1','salary','2000','2015-09'),
('1','2','bonus','100','2015-09'),
('1','3','indennity','250','2015-09'),
('1','1','salary','2000','2015-10'),
('1','2','bonus','0','2015-10'),
('1','3','indennity','150','2015-10'),
('2','1','salary','1500','2015-09'),
('2','2','bonus','0','2015-09'),
('2','3','indennity','50','2015-09')


SELECT Employee_id
	,Month_id
	,Salary
	,Bonus
	,indennity
FROM (
	SELECT employee_id
		,month_id
		,salary_component_desc
		,value
	FROM @t
	) p
pivot(sum(value) FOR salary_component_desc IN (
			[salary]
			,[bonus]
			,[indennity]
			)) x
ORDER BY employee_id
	,month_id







/*

Q3) Consider a MONTHLY_SALARY_AMOUNT table with three fields:
- employee_id
- month_id
- salary_amount
How would you write a SQL statement to have the following fields in each row:
- employee_id
- month_id
- salary_amount
- salary_amount the previous month
- salary_amount same month last year
*/

DECLARE @t TABLE (
	employee_id INT
	,Salary_Month date
	,Salary int
	)


insert into @t (employee_id,salary_month,Salary) values
('1','1/1/2019','79'), ('1','2/1/2019','87'), ('1','3/1/2019','93'), ('1','4/1/2019','80'), ('1','5/1/2019','99'), ('1','6/1/2019','78'), ('1','7/1/2019','75'), ('1','8/1/2019','87'), 
('1','9/1/2019','96'), ('1','10/1/2019','79'), ('1','11/1/2019','81'), ('1','12/1/2019','81'), ('1','1/1/2020','78'), ('1','2/1/2020','97'), ('1','3/1/2020','91'), 
('1','4/1/2020','81'), ('1','5/1/2020','99'), ('1','6/1/2020','90'), ('1','7/1/2020','92'), ('1','8/1/2020','80'), ('1','9/1/2020','80'), ('1','10/1/2020','97'), 
('1','11/1/2020','97'), ('1','12/1/2020','97'), ('1','1/1/2021','83'), ('1','2/1/2021','94'), ('1','3/1/2021','93'), ('1','4/1/2021','87'), ('1','5/1/2021','77'), 
('1','6/1/2021','81'), ('1','7/1/2021','85'), ('1','8/1/2021','84'), ('1','9/1/2021','89'), ('2','1/1/2019','93'), ('2','2/1/2019','80'), ('2','3/1/2019','95'), ('2','4/1/2019','76'), 
('2','5/1/2019','95'), ('2','6/1/2019','79'), ('2','7/1/2019','91'), ('2','8/1/2019','95'), ('2','9/1/2019','80'), ('2','10/1/2019','85'), ('2','11/1/2019','88'), 
('2','12/1/2019','75'), ('2','1/1/2020','86'), ('2','2/1/2020','91'), ('2','3/1/2020','96'), ('2','4/1/2020','95'), ('2','5/1/2020','81'), ('2','6/1/2020','99'), ('2','7/1/2020','98'), 
('2','8/1/2020','75'), ('2','9/1/2020','81'), ('2','10/1/2020','78'), ('2','11/1/2020','95'), ('2','12/1/2020','92'), ('2','1/1/2021','83'), ('2','2/1/2021','77'), 
('2','3/1/2021','100'), ('2','4/1/2021','87'), ('2','5/1/2021','86'), ('2','6/1/2021','99'), ('2','7/1/2021','84'), ('2','8/1/2021','95'), ('2','9/1/2021','95')




SELECT 
	employee_id
	,Salary_Month
	,thismonth = Salary
	,PriorMonth = lead(Salary, 1) OVER (
		PARTITION BY employee_id ORDER BY Salary_Month DESC
		)
	,PriorYear = lead(Salary, 12) OVER (
		PARTITION BY employee_id ORDER BY Salary_Month DESC
		)
FROM @t










/*
Q4) The Employee table holds all employees. Every employee has an Id, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1 | Joe | 85000 | 1 |
| 2 | Henry | 80000 | 2 |
| 3 | Sam | 60000 | 2 |
| 4 | Max | 90000 | 1 |
| 5 | Janet | 69000 | 1 |
| 6 | Randy | 85000 | 1 |
| 7 | Will | 70000 | 1 |
+----+-------+--------+--------------+
The Department table holds all departments of the company.

+----+----------+
| Id | Name |
+----+----------+
| 1 | IT |
| 2 | Sales |
+----+----------+
Write a SQL query to find employees who earn the top three salaries in each of the department. For the above tables, your SQL query should return the following rows (order of rows does not matter).

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT | Max | 90000 |
| IT | Randy | 85000 |
| IT | Joe | 85000 |
| IT | Will | 70000 |
| Sales | Henry | 80000 |
| Sales | Sam | 60000 |
+------------+----------+--------+
Explanation:

In IT department, Max earns the highest salary, both Randy and Joe earn the second highest salary, and Will earns the third highest salary. There are only two employees in the Sales department, Henry earns the highest salary while Sam earns the second highest salary.
*/


Declare @department table(
Departmentid int
,Department nvarchar(50))

insert into @department (Departmentid,Department) values
(1,'IT'),(2,'Sales')

DECLARE @employee TABLE (
	employee_id INT
	,Name nvarchar(50)
	,Salary int
	,Departmentid int
	)


insert into @employee (employee_id,Name,Salary,Departmentid) values
('1','Joe','85000','1'),
('2','Henry','80000','2'),
('3','Sam','60000','2'),
('4','Max','90000','1'),
('5','Janet','69000','1'),
('6','Randy','85000','1'),
('7','Will','70000','1'),
('8','Tom','65000','2'),
('9','Sarah','67000','2'),
('10','Hannah','80000','2')





;WITH rnk
AS (
	SELECT indx = dense_Rank() OVER (
			PARTITION BY departmentid ORDER BY salary DESC
			)
		,employee_id
		,name
		,salary
		,departmentid
	FROM @employee
	)
SELECT r.indx
	,d.department
	,r.name
	,r.salary
FROM rnk r
JOIN @department d ON r.departmentid = d.departmentid
WHERE indx <= 3









DROP TABLE IF EXISTS one;
create temp TABLE one(id INT);
INSERT INTO one (id)
VALUES 
	 (1)
	,(1)
	,(NULL);
	
DROP TABLE IF EXISTS two;
create temp TABLE two (id INT);
INSERT INTO two (id)
VALUES 
	 (1)
	,(1)
	,(NULL)
	,(NULL);
	


------Inner 4
SELECT 
	 a.*
	,b.*
FROM one a
	Inner JOIN two b 	
		ON a.id = b.id;
		
		
------LOJ 5
SELECT 
	 a.*
	,b.*
FROM one a
	left outer JOIN two b 	
		ON a.id = b.id;
		
		
------ROJ 6
SELECT 
	 a.*
	,b.*
FROM one a
	Right outer JOIN two b 	
		ON a.id = b.id;
	
	
------FOJ 7
SELECT 
	 a.*
	,b.*
FROM one a
	full outer JOIN two b 	
		ON a.id = b.id;








