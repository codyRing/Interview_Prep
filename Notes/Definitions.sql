
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