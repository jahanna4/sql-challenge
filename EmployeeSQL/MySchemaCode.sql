drop table if exists departments

create table departments(
	dept_no varchar,
	dept_name varchar
);

drop table if exists employees

create table employees (
	emp_no int,
	emp_title_id varchar,
	birth_date varchar,
	first_name varchar,
	last_name varchar,
	sex varchar,
	hire_date date
);

drop table if exists dept_emp

create table dept_emp (
	emp_no int,
	dept_no varchar
);

drop table if exists dept_manager

create table dept_manager (
	dept_no varchar,
	emp_no int
);

drop table if exists salaries

create table salaries (
	emp_no int,
	salary int
);

drop table if exists titles

create table titles (
	title_id varchar,
	title varchar
);

-- test import
select * from departments limit (5)
select * from employees limit (5)
select * from dept_emp limit (5)
select * from dept_manager limit (5)
select * from salaries limit (5)
select * from titles limit (5)

-- 1. employee number, last name, first name, sex & salary for each employee

select employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
from employees
inner join salaries on
employees.emp_no=salaries.emp_no;

-- 2. first name, last name, hire date for employees hired in 1986

select first_name, last_name, hire_date
from employees
where hire_date>'1985-12-31' and hire_date<'1987-01-01';

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
	
select departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
from
	(employees left outer join dept_manager on (employees.emp_no=dept_manager.emp_no)
	 join departments on (departments.dept_no=dept_manager.dept_no)
	)
;

-- 4. list the department of each employee with the following information: employee number, last name, first name, and department name.
		
select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from 
	(employees left outer join dept_emp on (employees.emp_no=dept_emp.emp_no)
	 join departments on (departments.dept_no=dept_emp.dept_no)
	)
;

-- 5. first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

select first_name, last_name, sex
from employees
where first_name='Hercules' and last_name like 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name

select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from
	(departments left outer join dept_emp on (departments.dept_no=dept_emp.dept_no)
	 join employees on (employees.emp_no=dept_emp.emp_no))
	 where
	 	(departments.dept_name='Sales')
;

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name

select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from
	(departments left outer join dept_emp on (departments.dept_no=dept_emp.dept_no)
	 join employees on (employees.emp_no=dept_emp.emp_no))
	 where
	 	(departments.dept_name='Sales' or departments.dept_name='Development')
;

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
select last_name, count(last_name) as "name count"
from employees
group by last_name
order by "name count" desc

