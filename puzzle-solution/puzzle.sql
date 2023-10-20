create database input;
use input;
create table input (
id int,
formula varchar(10),
value int
)
insert into input values (1,'1+4',10),(2,'2+1',5),(3,'3-2',40),(4,'4-1',20);

select * from input;
with cte as (
select *
,left(formula,1) as d1,RIGHT(formula,1) as d2,SUBSTRING(formula,2,1) as o
from input) 
select cte.id,cte.value,cte.formula,cte.o,ip1.value as d1_value,ip2.value as d2_value
,case when cte.o='+' then ip1.value +ip2.value else ip1.value-ip2.value end as new_value
from cte
inner join input ip1 on cte.d1=ip1.id
inner join input ip2 on cte.d1=ip2.id

