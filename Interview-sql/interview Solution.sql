create database call_start_logs;
use call_start_logs;
create table call_start_logs
(
phone_number varchar(10),
start_time datetime
);
insert into call_start_logs values
('PN1','2022-01-01 10:20:00'),('PN1','2022-01-01 16:25:00'),('PN2','2022-01-01 12:30:00')
,('PN3','2022-01-02 10:00:00'),('PN3','2022-01-02 12:30:00'),('PN3','2022-01-03 09:20:00')
create table call_end_logs
(
phone_number varchar(10),
end_time datetime
);
insert into call_end_logs values
('PN1','2022-01-01 10:45:00'),('PN1','2022-01-01 17:05:00'),('PN2','2022-01-01 12:55:00')
,('PN3','2022-01-02 10:20:00'),('PN3','2022-01-02 12:50:00'),('PN3','2022-01-03 09:40:00')
;

select * from call_start_logs;

select * from call_end_logs;

--join
select A.phone_number,A.rn,A.start_time,B.end_time,DATEDIFF(minute,start_time,end_time) as duration
from
(select *, row_number() over(partition by phone_number order by start_time) as rn from call_start_logs) A
inner join
(select *, row_number() over(partition by phone_number order by end_time) as rn from call_end_logs) B
on A.phone_number=B.phone_number and A.rn=B.rn

--union all

select phone_number,rn,min(call_time) as start_time,max(call_time) as end_time3,DATEDIFF(minute,min(call_time),max(call_time)) as duration
from
(select phone_number, start_time as call_time, ROW_NUMBER() over(partition by phone_number order by start_time) as rn from call_start_logs
union all
select *, row_number() over(partition by phone_number order by end_time) as rn from call_end_logs) A
group by phone_number,rn