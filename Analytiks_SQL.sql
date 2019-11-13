/* 1.
The following two tables are used to define users and Their respective roles:

Table users
id integer not null primary key,
username varchar(50) not null

table roles
id integer not null primary key,
role varchar(20) not null


the users_roels table should contain the mapping between each user and their roles.
each user can have many roles, and each role can have many users

modify the provided SQLite create table statement so that:

only users from the users table can exist within users_roles

Only roles from the roles table can exist within users_roles

a user can only have a specific role once
 */

--Drop table k_users_roles
--Drop table k_users
--Drop table k_roles

Create table k_users(
id integer not null primary key,
username varchar(50))

create table k_roles(
id integer not null primary key,
role varchar(20) not null)

Create table k_users_roles(
userid integer,
roleid integer,
foreign key(userid) references k_users(id),
foreign key(roleid) references k_roles(id),
unique (userid,roleid)
)


insert into k_users(id,username) values
(1,'stan'),
(2,'ollie'),
(3,'marie')

insert into k_roles(id,role)values
(1,'analyst'),
(2,'clerk')

insert into k_users_roles(userid,roleid)values
(1,2),
(2,1),
(1,1),
(3,1),
(3,2)
--(2,3) --Will fail because roleid 3 not in roles
--(4,2) --will fail because Userid 4 not in users
--(1,2) --will fail because userid 1 already has role of 2


Select * from k_users
select * from k_roles
select * from k_users_roles



---------------------------------------------------------------------------------------
/*2.
The following data definition defines an organizations' employee hierarchy.

An Employee is a manager if any other employee has their managerid set to the first employees id.

An employee who is a manager may or may not also have a manager

Table employees
id integer not null primary key,
managerid integer references (employees(id)
name varchar(30)

write a query that selects the names of employees who are not managers
 */
 
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

---except to find empno not in manager column
Select empno
from @employees
except
select mgr
from @employees


----same thing but with left join
Select 
emp.EMPNO
,emp.Ename
	from @employees emp
		left join @employees mgr
			on emp.EMPNO = mgr.MGR
where mgr.mgr is null



---------------------------------------------------------------------------------------
/* 3.
App usage data are kept in the following table:

Table Sessions
id integer primary key
userid integer not null
duration decimal not null

write a query that selects userid and average session duration for each user who has more than one session
 */
 
Declare @sessions table(
id integer primary key,
userid integer not null,
duration decimal (18,2) not null
)
insert into @sessions (id,userid,duration)values
(1,2,18.2),
(2,2,8.4),
(3,2,6.5),
(4,3,5.2),
(5,3,24.2),
(6,4,4.2)


select
s.userid,
AVG(duration) as average_Duration
from @sessions s
	join (
		select 
		userid,
		count(*) as occurence
		from @sessions
		group by userid
		having count(*)>1
		) mult_occurence 
			on s.userid = mult_occurence.userid
Group by s.userid



---------------------------------------------------------------------------------------
/* 4.
A table containing the students enrolled in a yearly course has incorrect data in records with ID's
between 20 and 100 inclusive

Write a query that updates teh filed 'year' of every faulty record to 2018

 */
 
Declare @enrollments table(
id integer not null primary key,
year integer not null,
studentid integer not null
)
insert into @enrollments(id,year,studentid) values
('66','2014','1'),
('97','2016','2'),
('84','2019','3'),
('78','2019','4'),
('24','2010','5'),
('90','2018','6'),
('48','2013','7'),
('22','2012','8'),
('58','2013','9'),
('20','2012','10'),
('26','2018','11'),
('4','2012','12'),
('9','2019','13'),
('59','2018','14'),
('7','2017','15'),
('51','2015','16'),
('75','2014','17'),
('31','2016','18'),
('83','2013','19'),
('18','2013','20'),
('72','2015','21'),
('44','2018','22'),
('21','2013','23'),
('30','2018','24'),
('57','2019','25')

select
distinct year
from @enrollments
where id between 20 and 100

update e
set year = 2015
from @enrollments e
where id between 20 and 100

select
distinct year
from @enrollments
where id between 20 and 100



---------------------------------------------------------------------------------------
/*6
each item in a web shop belongs to a seller. To ensure service quality, each seller has a rating

the data are kept in the following tables



write a query that selects the item name and the name of its seller for each item that belongs to a
seller witha rating greater than 4. The query should return the name of the item as the first column
and the name of the seller as the second column

 */
 
Declare @sellers table(
id integer not null primary key,
name varchar(30) not null,
rating integer not null
)


Declare @items table(
id integer not null primary key,
name varchar(30) not null,
sellerid integer 
)

insert into @sellers(id,name,rating)values
('1','nike','3'),
('2','ebay','1'),
('3','amazon','2'),
('4','offerup','5'),
('5','FB_Marketplace','3'),
('6','etsy','5'),
('7','overstock','5'),
('8','reddit','2'),
('9','paypal','1')

insert into @items (id,name,sellerid) values
('1','Item_1','9'),
('2','Item_2','8'),
('3','Item_3','7'),
('4','Item_4','7'),
('5','Item_5','6'),
('6','Item_6','6'),
('7','Item_7','1'),
('8','Item_8','6'),
('9','Item_9','9'),
('10','Item_10','8'),
('11','Item_11','5'),
('12','Item_12','4'),
('13','Item_13','1'),
('14','Item_14','9'),
('15','Item_15','3'),
('16','Item_16','7'),
('17','Item_17','8'),
('18','Item_18','3')


select
Rated_sellers.name
,i.name
from @items i
	join(
		Select id,name
		from @sellers
		where rating >4
		)Rated_sellers
		on i.sellerid = Rated_sellers.id



