use emp;
create table mode 
(
id int
);

insert into mode values (1),(2),(2),(3),(3),(3),(3),(4),(5);

select * from mode;

--method 1 cte
with freq_cte as (
select id, count(*) as freq from mode group by id)
select * from freq_cte
where freq=(select max(freq) from freq_cte)
;

select * from mode
insert into mode values (4)

--method 2

with freq_cte as (
select id, count(*) as freq from mode group by id)
, rnk_cte as (
select *
, rank() over(order by freq desc) as rn
from freq_cte)s

select * from rnk_cte where rn=1