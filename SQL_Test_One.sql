Drop Table dbo.Orders
Drop table dbo.Items

Create table dbo.Orders (
Order_id nvarchar(50),
Customer_Id nvarchar(50),
Order_DateTime DateTime,
Item_Id nvarchar(50),
Order_Qty int)

Create Table dbo.Items(
Item_Id nvarchar(50),
Item_Category nvarchar(50))

Insert into dbo.Orders (order_id,customer_id,ORder_Datetime,Item_ID,Order_Qty) values
('Order-1','Customer-15','2020-08-04 2:7:8','Item-1','27'),
('Order-2','Customer-12','2020-08-08 0:29:27','Item-10','5'),
('Order-3','Customer-4','2020-08-04 9:28:17','Item-3','15'),
('Order-4','Customer-15','2020-08-14 16:17:10','Item-5','15'),
('Order-5','Customer-16','2020-08-16 4:29:46','Item-10','25'),
('Order-6','Customer-15','2020-08-02 1:19:20','Item-1','26'),
('Order-7','Customer-11','2020-08-05 9:45:58','Item-3','10'),
('Order-8','Customer-7','2020-08-14 9:53:27','Item-5','25'),
('Order-9','Customer-6','2020-08-16 19:37:3','Item-8','12'),
('Order-10','Customer-15','2020-08-02 23:46:19','Item-9','21'),
('Order-11','Customer-3','2020-08-13 15:50:12','Item-1','31'),
('Order-12','Customer-19','2020-08-03 10:18:8','Item-3','41'),
('Order-13','Customer-9','2020-08-10 0:26:36','Item-3','10'),
('Order-14','Customer-23','2020-08-07 13:47:6','Item-2','44'),
('Order-15','Customer-6','2020-08-10 21:47:35','Item-7','46'),
('Order-16','Customer-9','2020-08-12 20:1:35','Item-7','48'),
('Order-17','Customer-2','2020-08-04 3:33:21','Item-10','19'),
('Order-18','Customer-1','2020-08-08 9:15:54','Item-10','8'),
('Order-19','Customer-3','2020-08-02 6:19:12','Item-5','16'),
('Order-20','Customer-17','2020-08-13 3:49:54','Item-9','41'),
('Order-21','Customer-11','2020-08-08 11:1:25','Item-4','21'),
('Order-22','Customer-4','2020-08-02 4:24:21','Item-6','41'),
('Order-23','Customer-25','2020-08-16 22:59:39','Item-9','44'),
('Order-24','Customer-5','2020-08-11 0:44:28','Item-6','5'),
('Order-25','Customer-15','2020-08-17 13:41:45','Item-7','21'),
('Order-26','Customer-6','2020-08-13 11:22:33','Item-7','14'),
('Order-27','Customer-1','2020-08-07 20:53:41','Item-3','19'),
('Order-28','Customer-2','2020-08-04 13:42:44','Item-4','19'),
('Order-29','Customer-13','2020-08-09 13:20:32','Item-9','31'),
('Order-30','Customer-17','2020-08-09 4:58:4','Item-6','26'),
('Order-31','Customer-22','2020-08-03 13:38:31','Item-8','39'),
('Order-32','Customer-21','2020-08-01 14:11:1','Item-4','14'),
('Order-33','Customer-6','2020-08-12 12:52:58','Item-10','42'),
('Order-34','Customer-22','2020-08-14 14:4:20','Item-1','28'),
('Order-35','Customer-12','2020-08-08 23:13:38','Item-6','24'),
('Order-36','Customer-5','2020-08-16 3:29:30','Item-6','26'),
('Order-37','Customer-17','2020-08-11 10:30:26','Item-2','10'),
('Order-38','Customer-21','2020-08-06 10:11:17','Item-7','45'),
('Order-39','Customer-20','2020-08-11 22:31:17','Item-10','40'),
('Order-40','Customer-11','2020-08-11 8:19:22','Item-7','22'),
('Order-41','Customer-5','2020-08-04 5:57:43','Item-3','22'),
('Order-42','Customer-12','2020-08-04 0:21:7','Item-9','25'),
('Order-43','Customer-6','2020-08-05 23:8:55','Item-10','47'),
('Order-44','Customer-25','2020-08-06 20:44:31','Item-5','16'),
('Order-45','Customer-13','2020-08-15 5:55:46','Item-1','36'),
('Order-46','Customer-1','2020-08-03 16:15:2','Item-2','4'),
('Order-47','Customer-23','2020-08-08 15:14:16','Item-7','43'),
('Order-48','Customer-9','2020-08-10 3:29:28','Item-3','36'),
('Order-49','Customer-8','2020-08-08 13:26:59','Item-5','35')

Insert into dbo.items(Item_Id,Item_Category) values
('Item-1','Sports'),
('Item-10','Kitchen'),
('Item-2','Outdoor'),
('Item-3','Garden'),
('Item-4','Grocery'),
('Item-5','Electronics'),
('Item-6','Furniture'),
('Item-7','Butcher'),
('Item-8','Coffee'),
('Item-9','Movie')

-- set a null item category
-- update Orders
-- set Item_Id = 'Item-6'
-- where Item_Id = 'Item-8'






/* Questions */ 
-- Q1: How many UNITS have been ordered yesterday? UNITS is the total quantity ordered.
-- Output as: Units

Select sum(Order_Qty) from dbo.Orders
--where Order_DateTime >= dateadd(d,-1,getdate())
where Order_DateTime >= cast(dateadd(d,-1,getdate()) as date)






-- Q2: How many UNITS have been ordered in the last 7 days (including today) in EACH and EVERY category? Please consider SEVEN calendar days in total, including today.
-- Please consider ALL categories, even those which have zero orders.
-- Output as: Category | Units

Select
i.Item_Category
,sum(o.Order_Qty)
From dbo.Items i
	 left join dbo.Orders o
		on i.Item_Id = o.Item_Id
where isnull(o.Order_DateTime,getdate()) >= dateadd(d,-7,getdate())
Group by i.Item_Category



-- Q3: How many UNITS in EACH and EVERY category have been ordered on each day of the week in the last 7 days (including today)? 
-- Output as: Category | Sunday_units | Monday_units | Tuesday_units | Wednesday_units | Thursday_units | Friday_units | Saturday_units

Select * from (

Select
i.Item_Category
,Wkday = Datename(weekday,order_datetime)
,o.Order_Qty
from dbo.Items i
	left join dbo.Orders o
		on i.Item_Id= o.Item_Id
where isnull(o.Order_DateTime,getdate()) >= dateadd(d,-7,getdate())
) p pivot (
sum (order_qty) for wkday in (
[Monday],
[Tuesday],
[Thursday],
[Wednesday],
[Friday],
[Saturday],
[Sunday])) x




-- Q4: It is possible for customers to place multiple orders on a single date.
-- For ALL customers, write a query to get the earliest ORDER_ID for each customer for each date they placed an order. 
-- Output as: Customer_id | Order_date | First_order_id

Select
Customer_id
,Order_Date
,First_order_id = Order_id
From (

select
indx= row_number() over(partition by customer_id,cast(order_datetime as date) order by order_datetime asc)
,Order_id
,Customer_Id
,Order_DateTime
,Order_Date = cast(order_datetime as date)
,Item_Id
,Order_Qty
from dbo.Orders o
)x
where x.indx = 1
order by Customer_Id





-- Q5: Write a query to get the second earliest ORDER_ID for each customer for each date they placed AT LEAST two orders. 
-- Output as: Customer_id | Order_date | Second_order_id


Select
Customer_id
,Order_Date
,Second_order_id = Order_id
From (

select
indx= row_number() over(partition by customer_id,cast(order_datetime as date) order by order_datetime asc)
,Order_id
,Customer_Id
,Order_DateTime
,Order_Date = cast(order_datetime as date)
,Item_Id
,Order_Qty
from dbo.Orders o
)x
where x.indx = 2
order by Customer_Id



















/* everything below are personal notes I used while answering the above questions */


---_Find APR Outliers
;with a as(
Select 
CarrierID
,carrier
,CoverageStart
,amount
,percentile = ntile(300) over(partition by carrier order by amount)
from dbo.Carrier_APR
where CoverageStart >= '1/1/2020' and amount >0
--order by carrier, amount desc
)

Select * from a
where percentile <=5 or percentile >=295
order by carrier, amount



----- What was the prior month amount
Select
CarrierID
,CoverageStart
,Amount
,PriorMthAmount = lead(amount,1)over(partition by carrierid order by coveragestart desc)
from dbo.Carrier_APR
where CoverageStart >= '1/1/2020' and amount >0



/* Find the 2nd highest APR Amount*/

Select * from (
Select
indx = dense_rank() over(partition by carrierid order by amount desc)
,CarrierID
,CoverageStart
,amount
from dbo.Carrier_APR
where isnull(carrierid,'') not like ''
--and CarrierID like '0AT0040821'
)x
where indx = 1







-----DateAdd

select top 10000
datepart(dw,Insert_Date)
,datename(dw,Insert_Date)
,datepart(m,Insert_Date)
,datename(m,Insert_Date)
,Insert_Date
,dateadd(d,-1,getdate())
,cast(dateadd(ww,-1,getdate()) as date)
 from dbo.RAS_APR
 --where Insert_Date >= dateadd(d,-1,getdate())  ------ all records from getdate() - 24 hours
--where Insert_Date  > cast(dateadd(d,-1,getdate()) as date) ------All records from yesterday
where Insert_Date  > cast(dateadd(d,-7,getdate()) as date) ------last 7 days
 order by Insert_Date desc
 
 -----Pivot W/O aggregatoin
 
Select Medigap,[part d],[part c] from (
Select 
rn = row_number() over (partition by product_Type order by first_name asc)
,First_name
,product_type
from ##ocupations
) p pivot( max(first_name) for product_Type in ([Medigap],[Part D],[Part c])) x
order by rn 


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