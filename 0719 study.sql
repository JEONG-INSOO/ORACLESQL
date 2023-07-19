--문제 1) 이름, 급여, 부서번호를 입력받아 EMP 테이블에 자료를 등록하는 스크립트를 작성해라.
--       단, 10번 부서일 경우 입력한 급여의 20%를 추가하고, 초기값이 9000부터 9999까지 1씩 증가하는 시퀀스를 작성하여 사용하고 아래의 표를 참고.

  CREATE or REPLACE procedure exec18_1(
  p_ename   in emp.ename %type
, p_deptno  in emp.deptno%type
, p_sal     in emp.sal   %type
) 
  as
    l_sal emp.sal%type := p_sal;
  begin
    if p_deptno = 10 then
       l_sal := p_sal * 1.2;
    end if;
    INSERT into emp(empno, ename, deptno, sal)
    VALUES(emp_empno_seq.nextval, p_ename, p_deptno, p_sal);
    exception
       when others then
         dbms_output.put_line(SQLCODE||'-'||SQLERRM);
  end;
  
  exec exec18_1('홍길동',10,1000);
  exec exec18_1('홍길동2',20,1000);
  select *
    from emp;
    
  DROP sequence emp_empno_seq;
  CREATE sequence emp_empno_seq
    increment by 1
    start with 9000
    minvalue 9000
    maxvalue 99999
    nocycle  --순환하지 않겠다
    nocache; --미리 시퀀스 번호를 생성하지 않겠다.
    
  select emp_empno_seq.nextval
    from dual;
  select emp_empno_seq.currval
    from dual;
 
  CREATE or REPLACE procedure exec18_2(
  p_name    in emp.ename%type
  )
  as
    l_job emp.job%type;
    l_sal emp.sal%type;
  begin
    select job, sal into l_job,l_sal
      from emp
     where ename = p_name;
     dbms_output.put_line(l_job);
     if l_job in ('MANAGER','ANALYST') then
          l_sal := l_sal *1.5;
     else 
          l_sal := l_sal *1.2;     
     end if;
     UPDATE emp
        set sal = l_sal
      where ename = p_ename;
      dbms_output.put_line(SQL%ROWCOUNT || '개의 행이 갱신되었습니다.');
    exception
        when other then
            dbms_output.put_line(SQLCODE||'-'||SQLERRM);
  end;
  
  select *
    from emp;
    exec exec18_2('SCOTT');

  select *
    from emp
   where ename = 'SCOTT'; 
   
-- 1~10까지의 합을 구하는 프로시저를 작성하시오  
-- 1) basic loop 문
create or replace procedure basicloop
as
    l_sum number := 0;
    l_cnt number := 0;
begin
    loop 
         l_cnt := l_cnt +1;
         l_sum := l_sum + l_cnt;
        exit when l_cnt = 10;
    end loop;
    dbms_output.put_line(l_sum);
end;
-- 2) while loop 문
create or replace procedure whileloop
as
    l_sum number := 0;
    l_cnt number := 0;
begin
    while l_cnt < 10  loop
      l_cnt := l_cnt + 1;
      l_sum := l_sum + l_cnt;
    end loop;
    dbms_output.put_line(l_sum);
end;
-- 3) for loop 문
create or replace procedure forloop
as
    l_sum number := 0;
begin
    for val in 1..10 loop
        l_sum := l_sum + val;
    end loop;
    dbms_output.put_line(l_sum);
end;  

--점수를 입력 받아 수,우,미,양,가로 출력하기
  CREATE or REPLACE procedure grade(
  p_score in number
  )
  as
    l_result varchar2(3);
  begin
    case 
        when p_score >= 90 then
            l_result := '수';
        when p_score >= 80 then
            l_result := '우';
        when p_score >= 70 then
            l_result := '미';
        when p_score >= 60 then
            l_result := '양';        
    else
            l_result := '가';      
    end case;
      dbms_output.put_line(l_result);
end;
  CREATE or REPLACE procedure grade2(
  p_score in number
  )
  as
    l_score number := trunc(p_score / 10);
    l_result varchar2(3);
  begin
    case l_score
        when  9 then
            l_result := '수';
        when  8 then
            l_result := '우';
        when  7 then
            l_result := '미';
        when  6 then
            l_result := '양';        
    else
            l_result := '가';      
    end case;
      dbms_output.put_line(l_result);
end;