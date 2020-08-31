------Load Data and setup ----------------------------------------------
Declare @employees table(
EMPNO int,
Ename nvarchar(50),
Job nvarchar(50),
MGR int,
HireDate date,
Sal	int,
Com int,
Deptno int)
insert into @employees (empno,ename,job,mgr,hiredate,sal,com,deptno)values
('7369','SMITH','CLERK','7902','12/17/1980','800',null,'20'),
('7499','ALLEN','SALESMAN','7698','2/20/1981','1600','300','30'),
('7521','WARD','SALESMAN','7698','2/22/1981','1250','500','30'),
('7566','JONES','MANAGER','7839','4/2/1981','2975',null,'20'),
('7654','MARTIN','SALESMAN','7698','9/28/1981','1250','1400','30'),
('7698','BLAKE','MANAGER','7839','5/1/1981','2850',null,'30'),
('7782','CLARK','MANAGER','7839','6/9/1981','2450',null,'10'),
('7788','SCOTT','ANALYST','7566','4/19/1987','3000',null,'20'),
('7839','KING','PRESIDENT',null,'11/17/1981','5000',null,'10'),
('7844','TURNER','SALESMAN','7698','9/8/1981','1500','0','30'),
('7876','ADAMS','CLERK','7788','5/23/1987','1100',null,'20'),
('7900','JAMES','CLERK','7698','12/3/1981','950',null,'30'),
('7902','FORD','ANALYST','7566','12/3/1981','3000',null,'20'),
('7934','MILLER','CLERK','7782','1/23/1982','1300',null,'10')

Declare @Job_History table(
EMPNO int,
StartDate date,
EndDate date,
Job nvarchar(50),
sal int,
com int,
deptno int,
chgdesc nvarchar (50))

insert into @Job_History(EMPNO,StartDate,EndDate,job,sal,com,deptno,chgdesc)values
('7369','12/17/1980',null,'CLERK','800',null,'20','New Hire'),
('7499','2/20/1981',null,'SALESMAN','1600','300','30','New Hire'),
('7521','2/22/1981',null,'SALESMAN','1250','500','30','New Hire'),
('7566','4/2/1981',null,'MANAGER','2975',null,'20','New Hire'),
('7654','9/28/1981',null,'SALESMAN','1250','1400','30','New Hire'),
('7698','5/1/1981',null,'MANAGER','2850',null,'30','New Hire'),
('7782','6/9/1981',null,'MANAGER','2450',null,'10','New Hire'),
('7788','4/19/1987','4/12/1988','CLERK','1000',null,'20','New Hire'),
('7788','4/13/1988','5/4/1989','CLERK','1040',null,'20','Raise'),
('7788','5/5/1990',null,'ANALYST','3000',null,'20','Promoted to Analyst'),
('7839','11/17/1981',null,'PRESIDENT','5000',null,'10','New Hire'),
('7844','9/8/1981',null,'SALESMAN','1500','0','30','New Hire'),
('7876','5/23/1987',null,'CLERK','1100',null,'20','New Hire'),
('7900','12/3/1981','1/14/1983','CLERK','950',null,'10','New Hire'),
('7900','1/15/1983',null,'CLERK','950',null,'30','Changed to Dept 30'),
('7902','12/3/1981',null,'ANALYST','3000',null,'20','New Hire'),
('7934','1/23/1982',null,'CLERK','1300',null,'10','New Hire')



Declare @department table(
deptno int,
Dname nvarchar(50),
loc nvarchar(50))
insert into @department(deptno,Dname,loc)values
('10','ACCOUNTING','NEW YORK'),
('20','RESEARCH','DALLAS'),
('30','SALES','CHICAGO'),
('40','OPERATIONS','BOSTON')



--1.1)	Write a query in SQL to display JOB, number of employees, sum of salary, and difference between highest salary and lowest salary for a job.
---*note this is only for employees current salary. Not taking into account history. 

Select 
job
,count(empno) as No_Employees
,sum(sal) as Total_Sal
,max(sal)-min(sal) as Sal_Differential
from @employees
Group by job



--2)	Write a query in SQL to display the ID for those employees who did two or more jobs in the past.

;with multiple_Jobs as(
select 
empno,
count( distinct job) as jobs -----This is assuming a clerk in accounting is the same job as a clerk in research (emp 7900). 7788 is the only person who went for clerk > analyst.
from @Job_History 
group by empno
having count( distinct job) >1
)

select 
e.EMPNO
from @employees e
	join multiple_Jobs m
		on	e.empno = m.empno
		


--3)	Write a query in SQL to display Name of employee with highest salary
------More details on question 4

Declare @rank int = 1
;with sal_rank as
		(
		Select
		dense_Rank() over( order by sal desc) as indx
		,empno
		,job
		,sal
		from @Job_History
		--where EndDate is null -----do we care about current jobs or the entire history?
		)
select
s.indx
,e.EMPNO
,e.Ename
,s.sal -----Grab sal values from Job_History opposed to their current salary
,s.Job
from @employees e
	join sal_rank s
		on e.EMPNO = s.EMPNO
where s.indx = @rank



--4)	Write a query in SQL to display Name of employee with second highest salary
--copied from question three. The dense rank function keeps the result sequential (opposed to rank). 
--You can change the first ID variable to get the highest salary or to 2 where 2 people had a sal of 3000

set @rank = 2
;with sal_rank as
		(
		Select
		dense_Rank() over( order by sal desc) as indx
		,empno
		,job
		,sal
		from @Job_History
		--where EndDate is null -----do we care about current jobs or the entire history?
		)

select
s.indx
,e.EMPNO
,e.Ename
,s.sal -----Grab sal values from Job_History opposed to their current salary
,s.Job
from @employees e
	join sal_rank s
		on e.EMPNO = s.EMPNO
where s.indx = @rank



---5)	Write a query in SQL to display the manager ID (MGR) and number of employees managed by the manager
---Key was to join the table to itself. People like the analyst scott 7566, an analyst with one direct report

select
mgr.EMPNO,
mgr.Ename as Manager_Name,
count(emp.ename) as num_employees

from @employees mgr
	join @employees emp
		on mgr.EMPNO = emp.MGR
		
group by mgr.EMPNO, mgr.Ename



--6)	Write a query to display the name ( ENAME ) for those employees who get more salary than the employee whose ID is 7566

declare @jones int = (Select sal from @employees where empno = 7566)

Select
ename
from @employees
where sal > @jones



--7)	Write a query to display the name ( first name and last name ), salary, department id for those employees who earn such amount of salary which is the smallest salary of any of the departments.

/*
 So a couple interesting things here about the Miniumum salary per department report

 1. Do we care about miniumum salary for current employes or over the departments history?

 2. No employees in operations
 
 3. Toggling between a null enddate to address point 1 brings up some thoughts
		
	 3A. EMP 7900 JAMES made a lateral move without a raise and is the minimum all time for accounting and research.

	 3B. Empno 7369. Smith has been with the company since 1980 and he's been making 800 as a cleark in research the entire time.
		Two other research clerks hired ~ 87 were making 1000. Shouldn't Smith get a raise!
	 
	 3C. Pretty positive the entire history isn't hear and can't tell the full detail of the salaries without it
	
 */

Select
min_sal.deptno
,min_sal.Dname
,min_sal.EMPNO
--,min_sal.EndDate
,case	
	when e.Ename is null then 'No Employees'
	else e.Ename
end as Ename
,min_sal.sal
from (
		select
		dense_rank() over(partition by d.deptno order by sal asc) as indx
		,d.deptno
		,d.Dname
		,j.EMPNO
		,j.sal
		,j.EndDate
		from @department d
			left join @Job_History j 
				on d.deptno = j.deptno
		--where j.EndDate is null  ---Should it be the lowest salary of all time or of the current employees? 
	) min_sal
		left join @employees e
			on min_sal.EMPNO = e.EMPNO
where min_sal.indx =1


