--different between where and having clause 

create database emp;
use emp;
CREATE TABLE emp_data (
    emp_id INT,
    emp_name VARCHAR(20),
    department_id INT,
    salary DECIMAL(30, 0),
    manager_id INT
);

select * from emp_data;

INSERT INTO emp_data (emp_id, emp_name, department_id, salary, manager_id)
VALUES (1, 'Ankit', 100, 10000, 4),
	   (2, 'Mohit', 100, 15000, 5),
	   (3, 'Vikas', 100, 10000, 4),
	   (4, 'Rohit', 100, 5000, 2),
	   (5, 'Mudit', 200, 12000, 6),
	   (6, 'Agam', 200, 12000, 2),
	   (7, 'Sanjay', 200, 9000, 2),
	   (8, 'Ashish', 200, 9000, 2);

select * from emp_data;

select * from emp_data
where salary>10000;


select department_id,AVG(salary) from emp_data
group by department_id
having avg(salary) > 9500

select department_id,AVG(salary) from emp_data
where salary>10000
group by department_id
having AVG(salary)>12000

