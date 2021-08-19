;WITH one
     AS (SELECT salary                              AS actual,
                Cast(Replace(salary, 0, '') AS INT) AS miscalculated
         FROM   employees),
     two
     AS (SELECT Avg(Cast(actual AS FLOAT))        AS actual,
                Avg(Cast(miscalculated AS FLOAT)) AS miscalculated
         FROM   one)
SELECT Cast(Ceiling(actual - miscalculated) AS INT)
FROM   two 