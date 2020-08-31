/*
I don't have the prompt for this question but going to try and re-write it from memory

The two tables and values were already supplied.

A teacher asks for a report That is partitioned by 10 point intervals and ordered by Name within the partition.

For every student who scored between 90 and 100 order them by first name.
The next partition 80-89 order by first name
Anyone below a score of 8 should not list the name 


*/

-- use mint
;drop table Students
;drop table Grades

;create temporary table Students (id int, name varchar(50) ,marks int)
;create temporary table Grades (Grade int, Min_Mark int ,max_mark int)
;insert into Students (id,name,marks) values
(19,'Samantha',87),
(21,'Julia',96),
(11,'Britney',95),
(32,'Kristeen',100),
(12,'Dyana',55),
(13,'Jenny',66),
(14,'Christene',88),
(15,'Meera',24),
(16,'Priya',76),
(17,'Priyanka',77),
(18,'Paige',74),
(19,'Jane',64),
(21,'Belvet',78),
(31,'Scarlet',80),
(41,'Salma',81),
(51,'Amanda',34),
(61,'Heraldo',94),
(71,'Stuart',99),
(81,'Aamina',77),
(76,'Amina',89),
(91,'Vivek',84)

; insert into grades(grade,min_mark,max_mark) values
(1,0,9),
(2,10,19),
(3,20,29),
(4,30,39),
(5,40,49),
(6,50,59),
(7,60,69),
(8,70,79),
(9,80,89),
(10,90,100)


;SELECT name
	,grade
	,marks
FROM (
	SELECT Row_number() OVER (
			PARTITION BY grade ORDER BY s.name ASC
			) AS indx
		,CASE 
			WHEN g.grade < 8
				THEN NULL
			ELSE s.name
			END AS name
		,s.marks
		,g.grade
	FROM students s
		JOIN grades g 
			ON s.marks BETWEEN g.min_mark AND g.max_mark
	) x
ORDER BY grade DESC
	,indx
 
 
 
 
 
 
 
 /*
One more pivot example. The question here was to transform two different log table from diffrent instances of a site.
Needed to take the rows for "Experiments" and "Visitors" and pivot those.


*/
 
 
 SELECT user_id
    ,Dates
    ,isnull(Experiment,0)
    ,isnull(Visitors,0)
    ,platform
FROM (
    SELECT user_id
        ,dates
        ,value
        ,type
        ,platform = 'V0'
    FROM v0_events
    ) p
pivot(sum(value) FOR type IN (
            [Experiment]
            ,[visitors]
            )) x
            
Union all

SELECT user_id
    ,Dates
    ,isnull(Experiment,0)
    ,isnull(Visitors,0)
    ,platform
FROM (
    SELECT user_id
        ,dates
        ,value
        ,type
        ,platform = 'V1'
    FROM v1_events
    ) p
pivot(sum(value) FOR type IN (
            [Experiment]
            ,[visitors]
            )) x   