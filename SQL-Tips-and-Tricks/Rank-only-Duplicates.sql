use emp;

create table list (id varchar(5));
insert into list values ('a');
insert into list values ('a');
insert into list values ('b');
insert into list values ('c');
insert into list values ('c');
insert into list values ('c');
insert into list values ('d');
insert into list values ('d');
insert into list values ('e');

select * from list;

select id from list group by id having count(1)>1;

--rank the duplicates records

with cte_dup as
(select id from list group by id having count(1)>1)
,cte_rank as (select *, rank() over(order by id asc) as rn from cte_dup)
select l.*, 'DUP' + cast(cr.rn as varchar(2)) as output
from list l
left join cte_rank cr on l.id=cr.id
;

