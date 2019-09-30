#Вывести среднюю зарплату сотрудников, округленныю до целого числа
select round(avg(salary), 0)
from employee;

#Вывести имя и зарплаты сотрудников, получающих заработную плату большую чем средняя по компании
select name, salary
from employee
where salary > (select avg(salary) from employee);
create table department (
  id   int(64) primary key auto_increment,
  name varchar(64) not null
);

create table employee (
  id            int(64) primary key auto_increment,
  department_id int(64)     not null,
  name          varchar(64) not null,
  salary        int(32)     not null,
  constraint employee_department_id_fk foreign key (department_id) references department (id)
);

insert into department (name)
values ('qa'),
       ('dev'),
       ('pm'),
       ('support'),
       ('hr');

insert into employee (department_id, name, salary)
values (2, 'sergey', 400),
       (2, 'kol9n', 500),
       (1, 'kate', 300),
       (1, 'oleg', 300),
       (1, 'sveta', 300),
       (3, 'denis', 700),
       (4, 'nastia', 200),
       (4, 'nastia_2', 200),
       (5, 'sasha', 600),
       (5, 'yala', 600),
       (5, 'tan9', 300);

#Вывести список ID отделов и макс зп по ним
select department_id, max(salary)
from employee
group by department_id;

#Вывести список сотрудников, получающих максимальную заработную плату в своем отделе
#вариант 1
select a.*
from employee a
where a.salary =
      (select max(salary) from employee b where b.department_id = a.department_id);
#вариант 2
select a.*
from employee a
         join (select department_id as d_id, max(salary) msal from employee b group by department_id) as ms
              on a.department_id = ms.d_id and msal = a.salary;

#Вывести список ID отделов, количество сотрудников в которых меньше 3 человек
select department_id, count(*)
from employee
group by department_id
having count(*) < 3;

#Вывести суммарные расходы по зп по каждому отделу в порядке убывания
select department_id, sum(salary)
from employee
group by department_id
order by sum(salary) desc;

#Объединить обе таблицы и вывести все поля
select *
from employee
         join department on employee.department_id = department.id;

#Вывести название отдела, в котором на зарплату тратится больше всего
select department.name
from employee
         join department on employee.department_id = department.id
group by department.name
order by sum(salary) desc
limit 1;