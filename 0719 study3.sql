  select department_id
,        sum(salary) as "Sum Salary"
,        NTILE(4) over (order by sum(salary) desc) as "Bucket#"
    from Employees
group by department_id
order by 3;

  select *
    from employees;

  select last_name || first_name, salary
,        ntile(5) over(order by salary desc)"순위등급"
    from employees;
    
  select employee_id, last_name,salary,department_id
,        rank      () over(partition by department_id order by salary desc)"rank"
,        dense_rank() over(partition by department_id order by salary desc)"dense_rank"
,        row_number() over(partition by department_id order by salary desc)"row number"
    from employees
order by department_id;

--분석함수 : 행의 손실없이 행과 행간의 비교 연산을 위한 함수.
  select employee_id, last_name, salary
,        lag(salary,1,0) over(order by employee_id) prev_sal
,        lead(salary,1,0) over(order by employee_id) nextval
    from employees;
    
  select department_id, count(*)
,        max(last_name) keep(dense_rank first order by salary desc) max_salary
,        min(last_name) keep(dense_rank last  order by salary desc) min_salary
    from employees
group by department_id
order by department_id;

  select department_id, job_id
,        to_char(sum(salary), '$999,999.00') as "Salary SUM"
,        COUNT(employee_id) as "COUNT EMPs"
    from employees
group by department_id, job_id
order by department_id;

