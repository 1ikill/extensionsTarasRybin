--install an extension
create extension pg_stat_statements;
create extension pgcrypto;

--listing installed extensions:
select * from pg_extension;

--create table employees
create table employees (
   id serial primary key,
   first_name varchar(255),
   last_name varchar(255),
   email varchar(255),
   encrypted_password text
);

--insert sample employee data into the table. 
insert into employees (first_name, last_name, email, encrypted_password) values
   ('maksim', 'talkachou', 'maksim.talkachou@student.ehu.lt', crypt('69696969696', gen_salt('bf'))),
   ('dmitry', 'pytaylo', 'dmitry.pytaylo@student.ehu.lt', crypt('dima1501', gen_salt('bf'))),
   ('darya', 'korbut', 'daryа.korbut@student.ehu.lt', crypt('lfifrjh,en', gen_salt('bf')));
   

--select all employees:  
select * from employees;

--update an employee's personal information
update employees set last_name = 'python' where email = 'dmitry.pytaylo@student.ehu.lt';

select * from employees;

-- delete an employee record using email

delete from employees where email = 'daryа.korbut@student.ehu.lt';

select * from employees;

--configure the pg_stat_statements extension
alter system set shared_preload_libraries to 'pg_stat_statements';
alter system set pg_stat_statements.track to 'all';

--run statistics for the executed statements:
select * from pg_stat_statements;


--identify the most frequently executed queries
select query, calls 
from pg_stat_statements
order by calls desc;

-- determine which queries have the highest average and total runtime

select query, total_plan_time as total_time , total_plan_time /calls as avg_time
from pg_stat_statements
order by avg_time, total_time desc;
















