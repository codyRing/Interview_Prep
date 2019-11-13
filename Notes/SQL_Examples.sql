use RAS_APR_Reconciliation
Drop Table dbo.transactions
Drop Table dbo.customers


CREATE TABLE dbo.customers (
--CustomerID uniqueidentifier primary key DEFAULT NEWSEQUENTIALID() not null,
CustomerID int IDENTITY (1,1) primary key NOT NULL,
First_Name nvarchar(50),
Last_Name nvarchar(50),
date datetime
);


CREATE TABLE dbo.transactions (
--CustomerID uniqueidentifier foreign key references customers(CustomerID) not null,
CustomerID int foreign key references customers(CustomerID) not null,
trans_ID int,
trans_Date datetime
);

/* 15) What are the difference between clustered and a non-clustered index?
	A clustered index is a special type of index that reorders the way records in the table are physically stored. 
	Therefore table can have only one clustered index. The leaf nodes of a clustered index contain the data pages.
	
	A non clustered index is a special type of index in which the logical order of the index does not match the physical stored order of the rows 
	on disk. The leaf node of a non clustered index does not consist of the data pages. Instead, the leaf nodes contain index rows. 
	
16) What is PRIMARY KEY?
	A PRIMARY KEY constraint is a unique identifier for a row within a database table. Every table should have a primary key constraint to uniquely identify each row and only one primary key constraint can be created for each table. The primary key constraints are used to enforce entity integrity.
	
17) What is FOREIGN KEY?

	A FOREIGN KEY constraint prevents any actions that would destroy links between tables with the corresponding data values. A foreign key in one table points to a primary key in another table. Foreign keys prevent actions that would leave rows with foreign key values when there are no primary keys with that value. The foreign key constraints are used to enforce referential integrity.
	
18) What's the difference between a primary key and a unique key?
	
	Both primary key and unique key enforces uniqueness of the column on which they are defined. 
	But by default primary key creates a clustered index on the column, where are unique creates a non-clustered index by default. 
	Another major difference is that, primary key doesn't allow NULLs, but unique key allows one NULL only.	

	
	
	*/
	
--String Functions
select
left(carrier_member_id,5),
right(carrier_member_id,5),
substring(carrier_member_id,6,3),
charindex('3',Carrier_Member_id),
rtrim(carrier_member_id),
LTRIM(carrier_member_id),
Carrier_Member_id
from dbo.RAS_MemberPremiumPayments



---Minus and except, records in one table and not the other
select aid,last_name from dbo.MMAMembers
except
select holder_aid,Last_Name from dbo.RAS_MemberPremiumPayments;

(select aid,last_name from dbo.MMAMembers)
intersect
(select holder_aid,Last_Name from dbo.RAS_MemberPremiumPayments)

------authors and books

select * 
from(
	select
	row_number() over(order by  sum(b.sold_copies) desc) as indx,
	a.author_name,
	sum(b.sold_copies) books
	from dbo.authors a 
		join dbo.books b
			on a.book_name = b.book_name
	group by a.author_name
) x
where indx = 1

--What revision control method do you use


commit 
rollback