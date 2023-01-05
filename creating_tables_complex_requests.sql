create table employees(
	id serial primary key,
	employee_name varchar (50) not null
);

insert into employees(employee_name)
values   ('Ivan0'),
		 ('Ivan1'),
		 ('Ivan2'),
		 ('Ivan3'),
		 ('Ivan4'),
		 ('Ivan5'),
		 ('Ivan6'),
		 ('Ivan7'),
		 ('Ivan8'),
		 ('Ivan9'),
		 ('Ivan10'),
		 ('Ivan11'),
		 ('Ivan12'),
		 ('Ivan13'),
		 ('Ivan14'),
		 ('Ivan15'),
		 ('Ivan16'),
		 ('Ivan17'),
		 ('Ivan18'),
		 ('Ivan19'),
		 ('Ivan20'),
		 ('Ivan21'),
		 ('Ivan22'),
		 ('Ivan23'),
		 ('Ivan24'),
		 ('Ivan25'),
		 ('Ivan26'),
		 ('Ivan27'),
		 ('Ivan28'),
		 ('Ivan29'),
		 ('Ivan30'),
		 ('Ivan31'),
		 ('Ivan32'),
		 ('Ivan33'),
		 ('Ivan34'),
		 ('Ivan35'),
		 ('Ivan36'),
		 ('Ivan37'),
		 ('Ivan38'),
		 ('Ivan39'),
		 ('Ivan40'),
		 ('Ivan41'),
		 ('Ivan42'),
		 ('Ivan43'),
		 ('Ivan44'),
		 ('Ivan45'),
		 ('Ivan46'),
		 ('Ivan47'),
		 ('Ivan48'),
		 ('Ivan49'),
		 ('Ivan50'),
		 ('Ivan51'),
		 ('Ivan52'),
		 ('Ivan53'),
		 ('Ivan54'),
		 ('Ivan55'),
		 ('Ivan56'),
		 ('Ivan57'),
		 ('Ivan58'),
		 ('Ivan59'),
		 ('Ivan60'),
		 ('Ivan61'),
		 ('Ivan62'),
		 ('Ivan63'),
		 ('Ivan64'),
		 ('Ivan65'),
		 ('Ivan66'),
		 ('Ivan67'),
		 ('Ivan68'),
		 ('Ivan69'),
		 ('Ivan70');

create table salary(
	id serial primary key,
	monthly_salary int not null
);

insert into salary(monthly_salary)
values (1000),
	   (1100),
	   (1200),
	   (1300),
	   (1400),
	   (1500),
	   (1600),
	   (1700),
	   (1800),
	   (1900),
	   (2000),
	   (2100),
	   (2200),
	   (2300),
	   (2400);
	   
create table roles(
	id serial primary key,
	role_name int unique not null
);

alter table roles
alter column role_name type varchar (30) using role_name::varchar (30);

insert into roles(role_name)
values   ('Junior Python developer'),
		 ('Middle Python developer'),
		 ('Senior Python developer'),
		 ('Junior Java developer'),
		 ('Middle Java developer'),
		 ('Senior Java developer'),
		 ('Junior JavaScript developer'),
		 ('Middle JavaScript developer'),
		 ('Senior JavaScript developer'),
		 ('Junior Manual QA engineer'),
		 ('Middle Manual QA engineer'),
		 ('Senior Manual QA engineer'),
		 ('Project Manager'),
		 ('Designer'),
		 ('HR'),
		 ('CEO'),
		 ('Sales manager'),
		 ('Junior Automation QA engineer'),
		 ('Middle Automation QA engineer'),
		 ('Senior Automation QA engineer');
		 
create table employee_salary(
	id serial primary key,
	employee_id int unique not null,
	salary_id int not null
);


insert into employee_salary(employee_id, salary_id)
values (1, 3),
	   (70, 4),
	   (55, 5),
	   (44, 1),
	   (32, 11),
	   (49, 9),
	   (17, 15),
	   (15, 10),
	   (69, 13),
	   (7, 7),
	   (8, 15),
	   (2, 15),
	   (3, 3),
	   (4, 14),
	   (61, 13),
	   (31, 12),
	   (23, 11),
	   (11, 1),
	   (58, 2),
	   (51, 6),
	   (35, 10),
	   (5, 15),
	   (18, 13),
	   (9, 14),
	   (12, 2),
	   (19, 3),
	   (24, 14),
	   (41, 10),
	   (47, 8),
	   (48, 4),
	   (88, 8),
	   (73, 15),
	   (99, 9),
	   (92, 1),
	   (74, 5),
	   (81, 11),
	   (94, 14),
	   (101, 10),
	   (77, 7),
	   (83, 13);
	  
create table roles_employee(
	id serial primary key,
	employee_id int unique not null,
	role_id int not null,
	foreign key(employee_id)
		references employees(id),
	foreign key(role_id)
		references roles(id)
);

insert into roles_employee(employee_id, role_id)
values (1, 3),
	   (70, 4),
	   (55, 5),
	   (44, 1),
	   (32, 11),
	   (49, 9),
	   (17, 15),
	   (15, 10),
	   (69, 13),
	   (7, 7),
	   (8, 15),
	   (2, 15),
	   (3, 3),
	   (4, 14),
	   (61, 13),
	   (31, 12),
	   (23, 17),
	   (11, 1),
	   (58, 2),
	   (51, 6),
	   (35, 18),
	   (5, 15),
	   (18, 13),
	   (9, 14),
	   (12, 2),
	   (19, 3),
	   (25, 14),
	   (41, 10),
	   (47, 8),
	   (48, 4),
	   (50, 20),
	   (52, 19),
	   (42, 18),
	   (43, 17),
	   (33, 16),
	   (34, 11),
	   (66, 14),
	   (14, 10),
	   (24, 7),
	   (28, 13);
	   

--Requests

-- 1. Вывести всех работников чьи зарплаты есть в базе, вместе с зарплатами.
select employee_name, monthly_salary 
  from employees
  	   join employee_salary 
  	   on employee_salary.employee_id = employees.id
       join salary 
       on salary.id = employee_salary.salary_id;

-- 2. Вывести всех работников у которых ЗП меньше 2000.
select employee_id, monthly_salary 
  from employee_salary
       join salary 
       on employee_salary.salary_id = salary.id
 where monthly_salary < 2000;

-- 3. Вывести все зарплатные позиции, но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
select employee_name, monthly_salary 
  from employees
  	   right join employee_salary 
  	   on employee_salary.employee_id = employees.id
       right join salary 
       on salary.id = employee_salary.salary_id;

-- 4. Вывести все зарплатные позиции  меньше 2000 но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
select employee_name, monthly_salary 
  from employees
  	   right join employee_salary 
  	   on employee_salary.employee_id = employees.id
       right join salary 
       on salary.id = employee_salary.salary_id
where monthly_salary < 2000;
      
-- 5. Найти всех работников кому не начислена ЗП.
select employee_name, monthly_salary 
  from employees
  	   left join employee_salary 
  	   on employee_salary.employee_id = employees.id
       left join salary 
       on salary.id = employee_salary.salary_id;

-- 6. Вывести всех работников с названиями их должности.
select employee_name, role_name
  from employees
	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id;
      
-- 7. Вывести имена и должность только Java разработчиков.
select employee_name, role_name
  from employees
	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id
 where role_name like '%Java developer%';

-- 8. Вывести имена и должность только Python разработчиков.
select employee_name, role_name
  from employees
	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id
 where role_name like '%Python developer%';

-- 9. Вывести имена и должность всех QA инженеров.
select employee_name, role_name
  from employees
	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id
 where role_name like '%QA%';

-- 10. Вывести имена и должность ручных QA инженеров.
select employee_name, role_name
  from employees
	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id
 where role_name like '%Manual QA%';

-- 11. Вывести имена и должность автоматизаторов QA
select employee_name, role_name
  from employees
	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id
 where role_name like '%Automation QA%';

-- 12. Вывести имена и зарплаты Junior специалистов
select employee_name, monthly_salary
  from employees
	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id
	   join employee_salary 
  	   on employee_salary.employee_id = employees.id
       join salary 
       on salary.id = employee_salary.salary_id	 
 where role_name like '%Junior%';

-- 13. Вывести имена и зарплаты Middle специалистов
select employee_name, monthly_salary
  from employees
	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id
	   join employee_salary 
  	   on employee_salary.employee_id = employees.id
       join salary 
       on salary.id = employee_salary.salary_id	 
 where role_name like '%Middle%';

-- 14. Вывести имена и зарплаты Senior специалистов
select employee_name, monthly_salary
  from employees
	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id
	   join employee_salary 
  	   on employee_salary.employee_id = employees.id
       join salary 
       on salary.id = employee_salary.salary_id	 
 where role_name like '%Senior%';

-- 15. Вывести зарплаты Java разработчиков
select monthly_salary
  from salary
  	   join employee_salary 
  	   on salary.id = employee_salary.salary_id
  	   join employees
  	   on employee_salary.employee_id = employees.id
  	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id 
 where role_name like '%Java developer%';

-- 16. Вывести зарплаты Python разработчиков
select monthly_salary
  from salary
  	   join employee_salary 
  	   on salary.id = employee_salary.salary_id
  	   join employees
  	   on employee_salary.employee_id = employees.id
  	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id 
 where role_name like '%Python developer%';

-- 17. Вывести имена и зарплаты Junior Python разработчиков
select employee_name, monthly_salary
  from employees
	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id
	   join employee_salary 
  	   on employee_salary.employee_id = employees.id
       join salary 
       on salary.id = employee_salary.salary_id	 
 where role_name like '%Junior Python%';

-- 18. Вывести имена и зарплаты Middle JS разработчиков
select employee_name, monthly_salary
  from employees
	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id
	   join employee_salary 
  	   on employee_salary.employee_id = employees.id
       join salary 
       on salary.id = employee_salary.salary_id	 
 where role_name like '%Middle JavaScript%';

-- 19. Вывести имена и зарплаты Senior Java разработчиков
select employee_name, monthly_salary
  from employees
	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id
	   join employee_salary 
  	   on employee_salary.employee_id = employees.id
       join salary 
       on salary.id = employee_salary.salary_id	 
 where role_name like '%Senior Java%';

-- 20. Вывести зарплаты Junior QA инженеров
select monthly_salary
  from salary
  	   join employee_salary 
  	   on salary.id = employee_salary.salary_id
  	   join employees
  	   on employee_salary.employee_id = employees.id
  	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id 
 where (role_name like '%Junior%') and (role_name like '%QA%');

-- 21. Вывести среднюю зарплату всех Junior специалистов
select avg(monthly_salary)
  from salary
  	   join employee_salary 
  	   on salary.id = employee_salary.salary_id
  	   join employees
  	   on employee_salary.employee_id = employees.id
  	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id 
 where role_name like '%Junior%';

-- 22. Вывести сумму зарплат JS разработчиков
select sum(monthly_salary)
  from salary
  	   join employee_salary 
  	   on salary.id = employee_salary.salary_id
  	   join employees
  	   on employee_salary.employee_id = employees.id
  	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id 
 where role_name like '%JavaScript%';

-- 23. Вывести минимальную ЗП QA инженеров
select min(monthly_salary)
  from salary
  	   join employee_salary 
  	   on salary.id = employee_salary.salary_id
  	   join employees
  	   on employee_salary.employee_id = employees.id
  	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id 
 where role_name like '%QA%';

-- 24. Вывести максимальную ЗП QA инженеров
select max(monthly_salary)
  from salary
  	   join employee_salary 
  	   on salary.id = employee_salary.salary_id
  	   join employees
  	   on employee_salary.employee_id = employees.id
  	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id 
 where role_name like '%QA%';

-- 25. Вывести количество QA инженеров
select count(role_name)
  from roles_employee
       join roles 
       on roles.id = roles_employee.role_id
 where role_name like '%QA%';

-- 26. Вывести количество Middle специалистов.
select count(role_name)
  from roles_employee
       join roles 
       on roles.id = roles_employee.role_id
 where role_name like '%Middle%';

-- 27. Вывести количество разработчиков
select count(role_name)
  from roles_employee
       join roles 
       on roles.id = roles_employee.role_id
 where role_name like '%developer%';

-- 28. Вывести фонд (сумму) зарплаты разработчиков.
select sum(monthly_salary)
  from salary
  	   join employee_salary 
  	   on salary.id = employee_salary.salary_id
  	   join employees
  	   on employee_salary.employee_id = employees.id
  	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id 
 where role_name like '%developer%';

-- 29. Вывести имена, должности и ЗП всех специалистов по возрастанию
select employee_name, role_name, monthly_salary
  from salary
  	   join employee_salary 
  	   on salary.id = employee_salary.salary_id
  	   join employees
  	   on employee_salary.employee_id = employees.id
  	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id 
 order by monthly_salary asc;

-- 30. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП от 1700 до 2300
select employee_name, role_name, monthly_salary
  from salary
  	   join employee_salary 
  	   on salary.id = employee_salary.salary_id
  	   join employees
  	   on employee_salary.employee_id = employees.id
  	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id
 where monthly_salary between 1700 and 2300
 order by monthly_salary asc;

-- 31. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП меньше 2300
select employee_name, role_name, monthly_salary
  from salary
  	   join employee_salary 
  	   on salary.id = employee_salary.salary_id
  	   join employees
  	   on employee_salary.employee_id = employees.id
  	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id
 where monthly_salary < 2300
 order by monthly_salary asc;

-- 32. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП равна 1100, 1500, 2000
select employee_name, role_name, monthly_salary
  from salary
  	   join employee_salary 
  	   on salary.id = employee_salary.salary_id
  	   join employees
  	   on employee_salary.employee_id = employees.id
  	   join roles_employee
	   on employees.id = roles_employee.employee_id
	   join roles
	   on roles.id = roles_employee.role_id
 where monthly_salary in (1100, 1500, 2000)
 order by monthly_salary asc;


