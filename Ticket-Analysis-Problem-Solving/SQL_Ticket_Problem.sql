/* write a sql to find business day between create date and resolved date by excluding 
weekend and public holidays */

create database tickets
use tickets;

create table tickets
(
ticket_id varchar(10),
create_date date,
resolved_date date
);
delete from tickets;
insert into tickets values
(1,'2022-08-01','2022-08-03')
,(2,'2022-08-01','2022-08-12')
,(3,'2022-08-01','2022-08-16');
create table holidays
(
holiday_date date
,reason varchar(100)
);
delete from holidays;
insert into holidays values
('2022-08-11','Rakhi'),('2022-08-15','Independence day');

select * from tickets;
select * from holidays;

select *
,datediff(day,create_date,resolved_date) as actual_days
,datepart(week,create_date)
,datepart(week,resolved_date)
,datediff(week,create_date,resolved_date) as weeks_diff
from tickets;

--Business Holidays in sheet
select *
,datediff(day,create_date,resolved_date) as actual_days
,datediff(day,create_date,resolved_date) - 2*datediff(week,create_date,resolved_date) as busines_days
from tickets;

--Holidays of the sheet
select * from holidays;

select *
--,datediff(day,create_date,resolved_date) as actual_days
--,datediff(day,create_date,resolved_date) - 2*datediff(week,create_date,resolved_date) as busines_days
from tickets
left join holidays on holiday_date between create_date and resolved_date

select * 
,datediff(day,create_date,resolved_date) as actual_days
,datediff(day,create_date,resolved_date) - 2*datediff(week,create_date,resolved_date)
- no_of_holidays
as business_days
from
(select ticket_id,create_date,resolved_date,COUNT(holiday_date) as no_of_holidays
--,datediff(day,create_date,resolved_date) as actual_days
--,datediff(day,create_date,resolved_date) - 2*datediff(week,create_date,resolved_date) as busines_days
from tickets
left join holidays on holiday_date between create_date and resolved_date
group by ticket_id,create_date,resolved_date) A