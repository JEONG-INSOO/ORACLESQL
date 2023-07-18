
/*급여를 입력 받아 하나 이상의 행을 return 하면 예외 처리기에서 " 사원이 한명 이십입니다"를 출력하고,
행이 없으면 "사원이 없습니다"를 출력하고 한명 있으면 이름, 업무, 급여를 출력해라.*/
  select *
    from emp;
    
  ACCEPT p_sal prompt '급여를 입력하세요'
  DECLARE
    l_sal emp.sal%type := &p_sal;
    type emp_rec_type is record(
        ename emp.ename%type
,       job   emp.job  %type
,       sal   emp.sal  %type
    );
    l_emp_rec emp_rec_type;
  BEGIN
    select ename, job, sal --단일행 다중열 : 개별변수 선언을 할 것이냐, 레코드 변수를 선언해서 레코드를 받는다.
      into l_emp_rec
      from emp
    where sal = l_sal;
    dbms_output.put_line(l_emp_rec.ename || 
','||                      l_emp_rec.job ||
','||                      l_emp_rec.sal);
    
    exception
        when no_data_found then
            dbms_output.put_line('급여에 맞는 사원이 없습니다.');
        when too_many_rows then
            dbms_output.put_line('2명 이상의 사원이 조회되었습니다.');
        when others then
            dbms_output.put_line(SQLCODE ||'-'|| SQLERRM);
end;

set serveroutput on;
/* 급여를 입력 받아 -100부터 +100 사이의 모든 사원을 출력하여라. */
  
  CREATE or REPLACE procedure exec21_2(
    p_sal   emp.sal%type
  )as
    cursor c_sal_of_emp is     select ename, sal
                                 from emp
                                where sal between p_sal -100 and p_sal+100; 
  begin
    for rec in c_sal_of_emp loop
        dbms_output.put_line(rec.ename ||','|| rec.sal );
    end loop;
    exception
        when others then
            dbms_output.put_line(SQLCODE ||','|| SQLERRM );
  end;

  CREATE or REPLACE procedure exec21_2_2(
    p_sal   emp.sal%type
  )as
    type emp_rec_type is record(
         ename emp.ename%type
,        sal   emp.sal  %type
);
  type emp_tab_type is table of emp_rec_type index by binary_integer;
  l_emp_tab emp_tab_type;
  begin
    select ename, sal
    bulk collect into l_emp_tab
      from emp
     where sal between p_sal -100 and p_sal +100;
     
    for idx in 1..l_emp_tab.count loop
        dbms_output.put_line(l_emp_tab(idx).ename ||','|| l_emp_tab(idx).sal );
    end loop;
    exception
        when others then
            dbms_output.put_line(SQLCODE ||','|| SQLERRM );
  end;