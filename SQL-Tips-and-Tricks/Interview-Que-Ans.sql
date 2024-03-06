use emp;

select * from emp_data;

-- Q1 -> How to find duplicates in a given table

select emp_id, count(*) from emp_data group by emp_id having count(*)>1;

-- Q2 -> How to delete duplicates
select * from emp1;

with cte as (select *, ROW_NUMBER() over(partition by emp_id order by emp_id) as rn from emp1)
delete from cte where rn>1;

-- Q3 -> different between union and union all

select manager_id from emp_data
--union
union all
select manager_id from emp1;

-- Q4 -> different between rank,row_number and dense_rank


-- Q5 -> employees who are not present in department table
CREATE TABLE dept (
    dep_id INT,
    dep_name VARCHAR(20),
);

INSERT INTO dept(dep_id, dep_name)
VALUES (100, 'Analytics'),
	   (300, 'IT');

select * from dept;

select * from emp1 where department_id not in (select dep_id from dept);

select emp1. * ,dept.dep_id,dept.dep_name from emp1
left join dept on emp1.department_id=dept.dep_id


-- Q6 -> second highest salary in each dep

select * from (select emp1.* ,dense_rank() over(partition by department_id order by salary desc) as rn from emp1) a
where rn=2

-- Q7 -> find all transaction done by shilpa

select * from emp1;

-- Q8 -> self join, manager salary > emp salary

