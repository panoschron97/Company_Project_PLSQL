set lines 400;
col first_name for a20;
col last_name for a20;
col salary for a20;

--sql query
select first_name,last_name,salary from employees where employee_id 
between 180 and 200;
--exit
exit;
