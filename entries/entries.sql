create database entries;

use entries;

create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR')

select * from entries;
with floor_visit as 
(select  
name, floor,count(1) no_of_floor_visit,
rank() over(partition by name order by count(1) desc) as rn
from entries
group by name,floor)
select fv.name,fv.floor as most_visited_floor
from floor_visit fv where rn=1;

with
total_visits as (select name,COUNT(1) as total_visits, string_agg(resources,',') resources_used from entries group by name )
,floor_visit as
(select  
name, floor,count(1) no_of_floor_visit,
rank() over(partition by name order by count(1) desc) as rn
from entries
group by name,floor)
select fv.name,fv.floor as most_visited_floor, tv.total_visits,tv.resources_used
from floor_visit fv
inner join total_visits tv on fv.name=tv.name 
where rn=1;


with 
distinct_resource as (select distinct name, resources from entries)
,agg_resources as (select name,string_agg(resources,',') as resources_used from distinct_resource group by name)
,total_visits as (select name,count(1) as total_visits, string_agg(resources,',') as resources_used from entries group by name)
,floor_visit as
(select  
name, floor,count(1) no_of_floor_visit,
rank() over(partition by name order by count(1) desc) as rn
from entries
group by name,floor)
select fv.name,fv.floor as most_visited_floor, tv.total_visits,ar.resources_used
from floor_visit fv
inner join total_visits tv on fv.name=tv.name
inner join agg_resources ar on fv.name=ar.name
where rn=1;