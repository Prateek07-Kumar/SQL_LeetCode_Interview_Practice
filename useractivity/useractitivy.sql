create database useractivity;
use useractivity;

create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');


select * from UserActivity;

-- Get the second Most Recent Activity , if there is only one activity then return that one

with cte as (
select *,
count(1) over(partition by username) as total_activites
,rank() over(partition by username order by startDate desc) as rnk
from UserActivity)
select * from cte where total_activites=1 or rnk=2;