create database players_location;
use players_location;

create table players_location
(
name varchar(20),
city varchar(20)
);
delete from players_location;
insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');

select * from players_location;

select *
, ROW_NUMBER() over(partition by city order by name asc) as player_groups
from players_location;

select player_groups
,max(case when city='Bangalore' then name end) as Bangalore
,max(case when city='Mumbai' then name end) as Mumbai
,max(case when city='Delhi' then name end) as Delhi
from 
(select *
,ROW_NUMBER() over(partition by city order by name asc) as player_groups
from players_location) A
group by player_groups;

select max(case when city='Bangalore' then name end) as Bangalore
,max(case when city='Mumbai' then name end) as Mumbai
,max(case when city='Delhi' then name end) as Delhi
from 
(select *
,ROW_NUMBER() over(partition by city order by name asc) as player_groups
from players_location) A
group by player_groups;