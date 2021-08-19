https://www.hackerrank.com/challenges/full-score/problem

with base as (
    select 
h.name
,s.submission_id
,s.hacker_id
,s.challenge_id
,s.score as submission_score
,c.difficulty_level
,d.score as difficulty_score
, case 
    when s.score>= d.score
    then cast(1 as int)
    else cast(0 as int)
end as full_score
from submissions s
    join hackers h
        on s.hacker_id = h.hacker_id
    
    join challenges c
        on s.challenge_id = c.challenge_id
        
    join difficulty d
        on c.difficulty_level = d.difficulty_level
)
select 
hacker_id
,name

-- ,sum(full_score)

from base 
-- where full_score =1
group by hacker_id,name
having sum(full_score)>1
order by sum(full_score) desc,hacker_id asc

