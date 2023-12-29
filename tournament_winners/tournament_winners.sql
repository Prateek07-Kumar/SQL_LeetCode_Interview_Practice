--Write an SQL query to find the winner in each group

/*The winner in each group is the player who scored the maximum total points ithin the group. 
In the case of a tie, the lowest player_id wins;*/

create database tournament_winners;
use tournament_winners;

create table players
(player_id int,
group_id int)

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int)

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);


select * from players

select * from matches;

select first_player as player_id, first_score as score from matches
union all
select second_player as player_id, second_score as score from matches

-------------------------------------------------------------------------------------------------
with player_scores as 
(select first_player as player_id, first_score as score from matches
union all
select second_player as player_id, second_score as score from matches)
select player_id,sum(score) as score
from player_scores
group by player_id;


-------------------------------------------------------------------------------------------------
with player_scores as 
(select first_player as player_id, first_score as score from matches
union all
select second_player as player_id, second_score as score from matches)

select p.group_id,ps.player_id,sum(score) as score
from player_scores ps
inner join players p on p.player_id=ps.player_id
group by p.group_id,ps.player_id


-------------------------------------------------------------------------------------------------
with player_scores as 
(select first_player as player_id, first_score as score from matches
union all
select second_player as player_id, second_score as score from matches)
, final_scores as (
select p.group_id,ps.player_id,sum(score) as score
from player_scores ps
inner join players p on p.player_id=ps.player_id
group by p.group_id,ps.player_id)

select *
,rank() over(partition by group_id order by score desc) as rn
from
final_scores


-------------------------------------------------------------------------------------------------
with player_scores as 
(select first_player as player_id, first_score as score from matches
union all
select second_player as player_id, second_score as score from matches)
, final_scores as (
select p.group_id,ps.player_id,sum(score) as score
from player_scores ps
inner join players p on p.player_id=ps.player_id
group by p.group_id,ps.player_id)
, final_ranking as (

select *
,rank() over(partition by group_id order by score desc, player_id asc) as rn
from
final_scores)

select * from final_ranking where rn=1

