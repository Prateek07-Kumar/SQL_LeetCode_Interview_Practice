create database Trade_tbl;
use Trade_tbl;


Create Table Trade_tbl(
TRADE_ID varchar(20),
Trade_Timestamp time,
Trade_Stock varchar(20),
Quantity int,
Price Float
);

Insert into Trade_tbl Values('TRADE1','10:01:05','ITJunction4All',100,20)
Insert into Trade_tbl Values('TRADE2','10:01:06','ITJunction4All',20,15)
Insert into Trade_tbl Values('TRADE3','10:01:08','ITJunction4All',150,30)
Insert into Trade_tbl Values('TRADE4','10:01:09','ITJunction4All',300,32)
Insert into Trade_tbl Values('TRADE5','10:10:00','ITJunction4All',-100,19)
Insert into Trade_tbl Values('TRADE6','10:10:01','ITJunction4All',-300,19)

Insert into Trade_tbl Values('TRADE1','10:10:00','Infosys',-100,19)
Insert into Trade_tbl Values('TRADE2','10:10:01','Infosys',-300,19)
Insert into Trade_tbl Values('TRADE3','10:01:05','Infosys',100,20)
Insert into Trade_tbl Values('TRADE4','10:01:06','Infosys',300,15)

/*Write SQL to find all couples of trade for same stock that happened in the range of 10 seconds
and having price difference by more than 10 %
Output result should also list the percentage of price difference between the 2 trade*/

select t1.TRADE_ID,t2.TRADE_ID, t1.Trade_Timestamp,t2.Trade_Timestamp,t1.Price,t2.Price 
,abs(t1.Price-t2.Price)*1.0/ t1.Price * 100
from Trade_tbl t1
inner join Trade_tbl t2  on 1=1
where t1.Trade_Timestamp<t2.Trade_Timestamp and DATEDIFF(second,t1.Trade_Timestamp,t2.Trade_Timestamp)<10
and abs(t1.Price-t2.Price)*1.0/ t1.Price * 100 > 10
order by t1.TRADE_ID

----------------------------------------------------------------------------------------------------------
select t1.Trade_Stock,t2.TRADE_ID, t1.Trade_Timestamp,t2.Trade_Timestamp,t1.Price,t2.Price 
,abs(t1.Price-t2.Price)*1.0/ t1.Price * 100
from Trade_tbl t1
inner join Trade_tbl t2  on t1.Trade_Stock=t2.Trade_Stock
where t1.Trade_Timestamp<t2.Trade_Timestamp and DATEDIFF(second,t1.Trade_Timestamp,t2.Trade_Timestamp)<10
and abs(t1.Price-t2.Price)*1.0/ t1.Price * 100 > 10
order by t1.TRADE_ID

select * from Trade_tbl;
select * from Trade_tbl;