use emp;

select * from emp1;

select e.emp_id,e.emp_name, m.emp_name as manager_name, e.salary , m.salary as manager_salary
from emp1 e
inner join emp1 m on e.manager_id=m.emp_id
where e.salary > m.salary;
